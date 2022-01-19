//
//  AddCategoryTitleViewController.swift
//  ShareExtension
//
//  Created by Noah on 2022/01/19.
//

import UIKit

import RxCocoa
import SnapKit

final class AddCategoryTitleViewController: BaseViewController {
    
    // MARK: - property
    
    weak var coordinator: ShareExtensionMainCoordinator?
    
    var keyboardHeight: CGFloat = 0
    
    private let navigationLeftButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(image: ImageLiteral.btnBackBlack,
                                            style: .plain,
                                            target: nil,
                                            action: nil)
        barButtonItem.tintColor = .havitGray
        
        return barButtonItem
    }()
    
    private let navigationRightButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .stop,
                                            target: nil,
                                            action: nil)
        barButtonItem.tintColor = .havitGray
        
        return barButtonItem
    }()
    
    private let addCategoryTitleNoticeLabel: UILabel = {
        let label = UILabel()
        label.text = "카테고리 제목을 입력하세요"
        label.font = .font(.pretendardSemibold, ofSize: 22)
        label.textColor = .gray005
        
        return label
    }()
    
    private let titleTextFieldHeader: UILabel = {
        let label = UILabel()
        label.text = "제목"
        label.font = .font(.pretendardSemibold, ofSize: 14)
        label.textColor = .havitPurple
        
        return label
    }()
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        let placeHolderAttribute = NSAttributedString(string: "카테고리 제목 입력",
                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray003])
        textField.font = .font(.pretendardMedium, ofSize: 19)
        textField.attributedPlaceholder = placeHolderAttribute
        textField.borderStyle = .none
        textField.textColor = .havitGray
        textField.tintColor = .havitPurple
        
        return textField
    }()
    
    private let titleTextFieldBottomline: UIView = {
        let view = UIView()
        view.backgroundColor = .havitPurple
        
        return view
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpKeyboardForButtonAnimation()
    }
    
    // MARK: - func
    
    override func configUI() {
        setNavigationBar()
    }
    
    override func render() {
        view.addSubViews([addCategoryTitleNoticeLabel,
                          titleTextFieldHeader,
                          titleTextField,
                          titleTextFieldBottomline,
                          nextButton])
        
        addCategoryTitleNoticeLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(40)
            $0.leading.equalToSuperview().inset(16)
        }
        
        titleTextFieldHeader.snp.makeConstraints {
            $0.top.equalTo(addCategoryTitleNoticeLabel.snp.bottom).offset(31)
            $0.leading.equalTo(addCategoryTitleNoticeLabel)
        }
        
        titleTextField.snp.makeConstraints {
            $0.top.equalTo(titleTextFieldHeader.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(24)
        }
        
        titleTextFieldBottomline.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(4)
            $0.leading.trailing.equalTo(titleTextField)
            $0.height.equalTo(1)
        }
        
        nextButton.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(56)
        }
    }
    
    private func setNavigationBar() {
        title = "카테고리 추가"
        navigationItem.leftBarButtonItem = navigationLeftButton
        navigationItem.rightBarButtonItem = navigationRightButton
    }
    
    private func bind() {
        titleTextField.rx.text
            .bind { [weak self] _ in
                if let isTitleFieldHasText = self?.titleTextField.hasText {
                    self?.nextButton.isEnabled = isTitleFieldHasText
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func setUpKeyboardForButtonAnimation() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        titleTextField.becomeFirstResponder()
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
