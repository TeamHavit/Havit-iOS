//
//  MainAlarmViewController.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/20.
//

import UIKit

import RxCocoa
import SnapKit

final class MainAlarmViewController: BaseViewController {
    
    // MARK: - property
    
    private let backButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
        button.setImage(ImageLiteral.btnBackBlack, for: .normal)
        return button
    }()
    private let infomationLabel: UILabel = {
        let label = UILabel()
        label.text = "지난 알림 콘텐츠가 없습니다."
        label.font = .font(.pretendardMedium, ofSize: 14)
        label.textColor = .gray002
        return label
    }()
    private let alarmImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiteral.imgGraphicNoalarm
        return imageView
    }()
    
    // MARK: - init
    
    override init() {
        super.init()
        hidesBottomBarWhenPushed = true
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func render() {
        view.addSubViews([infomationLabel, alarmImageView])
        
        alarmImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-30)
        }
        
        infomationLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(alarmImageView.snp.top).offset(-23)
        }
    }
    
    override func configUI() {
        super.configUI()
        view.backgroundColor = .white
        setupNavigationBar()
    }
    
    // MARK: - func
    
    private func bind() {
        backButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func setupNavigationBar() {
        title = "전체 알림"
        setupBaseNavigationBar(backgroundColor: .havitWhite,
                               titleColor: .primaryBlack,
                               isTranslucent: false,
                               tintColor: .primaryBlack)
        navigationItem.leftBarButtonItem = makeBarButtonItem(with: backButton)
    }
    
    private func makeBarButtonItem(with button: UIButton) -> UIBarButtonItem {
        return UIBarButtonItem(customView: button)
    }
}
