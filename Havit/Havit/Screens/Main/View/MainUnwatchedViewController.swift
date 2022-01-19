//
//  MainUnwatchedViewController.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/19.
//

import UIKit

import RxCocoa
import SnapKit

final class MainUnwatchedViewController: BaseViewController {
    
    // MARK: - property
    
    weak var coordinator: UnwatchedCoordinator?
    
    private let backButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
        button.setImage(ImageLiteral.btnBackBlack, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
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
                self?.coordinator?.performTransition(to: .previous)
            })
            .disposed(by: disposeBag)
    }
    
    private func setupNavigationBar() {
        title = "최근 저장 콘텐츠"
        setupBaseNavigationBar(backgroundColor: .havitWhite,
                               titleColor: .primaryBlack,
                               isTranslucent: false,
                               tintColor: .primaryBlack)
        let font = UIFont.font(.pretendardBold, ofSize: 16)
        navigationController?.navigationBar.titleTextAttributes = [.font: font]
        navigationItem.leftBarButtonItem = makeBarButtonItem(with: backButton)
    }
    
    private func makeBarButtonItem(with button: UIButton) -> UIBarButtonItem {
        return UIBarButtonItem(customView: button)
    }
}
