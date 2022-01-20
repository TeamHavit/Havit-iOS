//
//  AddContentViewController.swift
//  Havit
//
//  Created by Noah on 2022/01/21.
//

import UIKit

final class AddContentViewController: BaseViewController {
    
    // MARK: - property
    
    private var keyboardHeight: CGFloat = 0
    
    private let navigationRightButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .stop,
                                            target: nil,
                                            action: nil)
        barButtonItem.tintColor = .havitGray
        return barButtonItem
    }()
    
    private let urlInsertNoticeLabel: UILabel = {
        let label = UILabel()
        label.text = "URL 링크를 입력 및 붙여넣기 해주세요"
        label.font = .font(.pretendardBold, ofSize: 16)
        label.applyColor(to: "URL 링크", with: .havitPurple)
        return label
    }()
        
    private lazy var urlTextView: UITextView = {
        let textView = UITextView()
        textView.delegate = self
        textView.backgroundColor = .whiteGray
        textView.tintColor = .havitPurple
        textView.font = .font(.pretendardReular, ofSize: 13)
        textView.layer.cornerRadius = 4
        textView.contentInset = UIEdgeInsets(top: 12, left: 11, bottom: 12, right: 11)
        textView.isScrollEnabled = true
        return textView
    }()
    
    private let nextButton: UIButton = {
        var container = AttributeContainer()
        container.font = .font(.pretendardSemibold, ofSize: 16)
        
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = AttributedString("다음", attributes: container)
        configuration.background.cornerRadius = 0
        configuration.baseForegroundColor = .white
        configuration.background.backgroundColor = .havitPurple
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 17, leading: 173, bottom: 17, trailing: 174)
        
        let button = UIButton(configuration: configuration, primaryAction: nil)
        
        let buttonStateHandler: UIButton.ConfigurationUpdateHandler = { button in
            switch button.state {
            case .normal:
                button.configuration?.background.backgroundColor = .havitPurple
            case .disabled:
                button.configuration?.background.backgroundColor = .gray002
            default:
                return
            }
        }
        button.configurationUpdateHandler = buttonStateHandler
        return button
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setUpKeyboardForButtonAnimation()
    }
    
    // MARK: - func
    
    override func configUI() {
        setNavigationBar()
        view.backgroundColor = .white
    }
    
    override func render() {
        view.addSubViews([urlInsertNoticeLabel,
                          urlTextView,
                          nextButton])
        
        urlInsertNoticeLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(40)
            $0.leading.equalToSuperview().inset(16)
        }
        
        urlTextView.snp.makeConstraints {
            $0.top.equalTo(urlInsertNoticeLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(42)
        }

        nextButton.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(56)
        }
    }
    
    private func setNavigationBar() {
        title = "콘텐츠 저장"
        navigationItem.rightBarButtonItem = navigationRightButton
    }
    
    private func bind() {
        urlTextView.rx.text
            .map { [weak self] _ in
                self?.urlTextView.hasText ?? false
            }
            .bind {
                self.nextButton.isEnabled = $0
            }
            .disposed(by: disposeBag)
    }
    
    private func setUpKeyboardForButtonAnimation() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        urlTextView.becomeFirstResponder()
    }
    
    // MARK: - @objc
    
    @objc
    private func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyboardHeight = keyboardRectangle.height
        }
        
        UIView.animate(withDuration: TimeInterval(0.1), animations: {
            self.nextButton.transform = CGAffineTransform.init(translationX: 0, y: -(self.keyboardHeight))
        })
    }
}

extension AddContentViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let textViewBoundSize = textView.bounds.size
        let newTextViewSize = CGSize(width: textViewBoundSize.width, height: CGFloat.greatestFiniteMagnitude)
        let estimatedSize = textView.sizeThatFits(newTextViewSize)
        textView.constraints.forEach { constraint in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
}
