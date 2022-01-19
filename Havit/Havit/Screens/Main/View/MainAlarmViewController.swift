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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func render() {
        
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
