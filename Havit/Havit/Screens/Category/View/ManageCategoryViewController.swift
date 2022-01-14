//
//  ManageCategoryViewController.swift
//  Havit
//
//  Created by 김수연 on 2022/01/14.
//

import UIKit

class ManageCategoryViewController: BaseViewController {

    // MARK: - property
    
    weak var coordinator: ManageCategoryCoordinator?

    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "iconBackWhite"), for: .normal)
        return button
    }()

    private let doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("완료", for: .normal)
        button.titleLabel?.font = .font(.pretendardMedium, ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    // MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        bind()
    }

    override func render() {
    }

    private func setNavigationBar() {
        title = "카테고리 수정"
        let appearance = UINavigationBarAppearance()

        appearance.backgroundColor = .havitPurple
        appearance.titleTextAttributes = [
            .font: UIFont.font(.pretendardBold, ofSize: 16)
        ]
        
        navigationItem.leftBarButtonItem = makeBarButtonItem(with: backButton)
        navigationItem.rightBarButtonItem = makeBarButtonItem(with: doneButton)
    }

    // 이 함수가 앞에 categoryVC에도 똑같이 정의되어있는데 혹시 가져와서 쓸 쑤 있는 방법이 있을까요??
    private func makeBarButtonItem(with button: UIButton) -> UIBarButtonItem {
        button.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
        return UIBarButtonItem(customView: button)
    }

    private func bind() {
        backButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.coordinator?.performTransition(to: .category)
            })
            .disposed(by: disposeBag)

        doneButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.coordinator?.performTransition(to: .category)
            })
            .disposed(by: disposeBag)
    }
}
