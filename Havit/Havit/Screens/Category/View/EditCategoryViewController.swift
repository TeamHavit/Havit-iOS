//
//  EditCategoryViewController.swift
//  Havit
//
//  Created by 김수연 on 2022/01/16.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit

class EditCategoryViewController: BaseViewController {

    // MARK: - property

    weak var coordinator: EditCategoryCoordinator?

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "제목"
        label.font = .font(.pretendardSemibold, ofSize: 14)
        label.textColor = .havitPurple
        return label
    }()

    private var categoryTitleTextField: UITextField = {
        let text = UITextField()
        text.borderStyle = .none
        text.text = "일단 여기 이게 들어있고"
        text.textColor = .gray003
        text.tintColor = .havitPurple
        return text
    }()

    private let underline: UIView = {
        let view = UIView()
        view.backgroundColor = .havitPurple
        return view
    }()

    private let iconLabel: UILabel = {
        let label = UILabel()
        label.text = "아이콘"
        label.font = .font(.pretendardSemibold, ofSize: 14)
        label.textColor = .havitPurple
        return label
    }()

    private let iconCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(cell: CategoryIconCollectionViewCell.self)
        return collectionView
    }()

    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiteral.iconBackWhite, for: .normal)
        return button
    }()

    private let doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("완료", for: .normal)
        button.titleLabel?.font = .font(.pretendardMedium, ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    private let deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("삭제", for: .normal)
        button.setTitleColor(.havitRed, for: .normal)
        button.titleLabel?.font = .font(.pretendardMedium, ofSize: 15)
        button.backgroundColor = .gray000
        button.layer.cornerRadius = 6
        return button
    }()

    // MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegation()
    }

    override func render() {
        view.addSubViews([titleLabel, categoryTitleTextField, underline, iconLabel, iconCollectionView, deleteButton])

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(19)
            $0.leading.equalToSuperview().inset(16)
        }

        categoryTitleTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(9)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        underline.snp.makeConstraints {
            $0.top.equalTo(categoryTitleTextField.snp.bottom).offset(3)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }

        iconLabel.snp.makeConstraints {
            $0.top.equalTo(underline.snp.bottom).offset(39)
            $0.leading.equalToSuperview().inset(16)
        }

        iconCollectionView.snp.makeConstraints {
            $0.top.equalTo(iconLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }

        deleteButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(30)
            $0.height.equalTo(48)
        }
    }

    override func configUI() {
        setupBaseNavigationBar(backgroundColor: .havitPurple, titleColor: .white, isTranslucent: false, tintColor: .white)
        setNavigationItem()
        bind()
    }
    
    // MARK: - func

    private func setDelegation() {
        iconCollectionView.delegate = self
        iconCollectionView.dataSource = self
        categoryTitleTextField.delegate = self
    }

    private func setNavigationItem() {
        title = "카테고리 수정"
        let appearance = UINavigationBarAppearance()

        appearance.titleTextAttributes = [
            .font: UIFont.font(.pretendardBold, ofSize: 16)
        ]

        navigationItem.leftBarButtonItem = makeBarButtonItem(with: backButton)
        navigationItem.rightBarButtonItem = makeBarButtonItem(with: doneButton)
    }

    private func makeBarButtonItem(with button: UIButton) -> UIBarButtonItem {
        button.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
        return UIBarButtonItem(customView: button)
    }

    private func bind() {
        Observable.merge(
            backButton.rx.tap.map { $0 },
            doneButton.rx.tap.map { $0 }
        )
            .bind(onNext: { [weak self] in
                self?.coordinator?.performTransition(to: .previous)
            })
            .disposed(by: disposeBag)
    }
}

extension EditCategoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as CategoryIconCollectionViewCell
        return cell
    }
    
}

extension EditCategoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 62, height: 62)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
}

extension EditCategoryViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        categoryTitleTextField.textColor = .black
    }
}
