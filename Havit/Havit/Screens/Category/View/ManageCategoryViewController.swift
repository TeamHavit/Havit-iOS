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

    private lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(cell: CategoryCollectionViewCell.self)

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

    private let noticeIcon: UIImageView = {
        let image = UIImageView()
        image.image = ImageLiteral.iconNoticeGray
        return image
    }()

    private let noticeLabel: UILabel = {
        let label = UILabel()
        label.text = "카테고리를 누른 뒤 위아래로 드래그하여 순서를 바꿀 수 있습니다"
        label.font = .font(.pretendardReular, ofSize: 12)
        label.textColor = .gray002
        return label
    }()

    // MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegation()
    }

    override func viewWillDisappear(_ animated: Bool) {
        setupBaseNavigationBar(backgroundColor: .white)
    }

    override func render() {
        view.addSubViews([categoryCollectionView, noticeIcon, noticeLabel])

        noticeIcon.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(29)
            $0.leading.equalToSuperview().inset(26)
            $0.bottom.equalTo(categoryCollectionView.snp.top).inset(-15)
            $0.width.height.equalTo(12)
        }

        noticeLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(26)
            $0.leading.equalTo(noticeIcon.snp.trailing).offset(5)
            $0.bottom.equalTo(categoryCollectionView.snp.top).inset(-13)
        }

        categoryCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(56)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }

    override func configUI() {
        view.backgroundColor = .white
        setupBaseNavigationBar(backgroundColor: .havitPurple, titleColor: .white, shadowImage: UIImage(), isTranslucent: false, tintColor: .white)
        setNavigationItem()
        bind()
    }

    // MARK: - func

    private func setDelegation() {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
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
        backButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.coordinator?.performTransition(to: .previous)
            })
            .disposed(by: disposeBag)

        doneButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.coordinator?.performTransition(to: .previous)
            })
            .disposed(by: disposeBag)
    }
}

extension ManageCategoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as CategoryCollectionViewCell
        
        cell.configure(type: .manage)
        return cell
    }
}

extension ManageCategoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width - 32, height: 56)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
