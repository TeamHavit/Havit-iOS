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

    var categoryId: Int
    var titleText: String
    var iconImageId: Int
    var sendData: (() -> Void)?

    let categoryService: CategorySeriviceable = CategoryService(apiService: APIService(), environment: .development)

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
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
        button.setImage(ImageLiteral.iconBackWhite, for: .normal)
        return button
    }()

    private let doneButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
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

    // MARK: - init

    init(categoryId: Int, titleText: String, imageId: Int) {
        self.categoryId = categoryId
        self.titleText = titleText
        categoryTitleTextField.text = titleText
        self.iconImageId = imageId

        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegation()
    }

    func editCategory() {
        Task {
            do {
                try await categoryService.editCategory(categoryId: categoryId ?? 0, title: categoryTitleTextField.text ?? "", imageId: iconImageId ?? 0)
                self.makeAlert(title: "카테고리 수정", message: "카테고리 수정 성공", okAction: { [weak self] _ in
                    self?.sendData?()
                    self?.navigationController?.popViewController(animated: true)
                })
            } catch APIServiceError.serverError {
                print("serverError")
            } catch APIServiceError.clientError(let message) {
                print("clientError:\(String(describing: message))")
            }
        }
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
        view.backgroundColor = .white
        setupBaseNavigationBar(backgroundColor: .havitPurple, titleColor: .white, isTranslucent: false, tintColor: .white)
        setNavigationItem()
        bind()
    }
    
    // MARK: - func

    private func setDelegation() {
        iconCollectionView.delegate = self
        iconCollectionView.dataSource = self
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
        return UIBarButtonItem(customView: button)
    }

    private func bind() {
        backButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)

        doneButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.editCategory()
            })
            .disposed(by: disposeBag)
        
        categoryTitleTextField.rx.controlEvent([.editingDidBegin])
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.categoryTitleTextField.textColor = .black
            })
            .disposed(by: disposeBag)
    }
}

extension EditCategoryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        iconImageId = indexPath.row + 1
    }
}

extension EditCategoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as CategoryIconCollectionViewCell

        if indexPath.row == iconImageId - 1 {
            cell.isSelected = true
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
        } else {
            cell.isSelected = false
        }

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
