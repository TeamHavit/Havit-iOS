//
//  CategoryViewController.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/06.
//

import UIKit

import SnapKit
import RxCocoa

class CategoryViewController: BaseViewController {

    // MARK: - property

    private var categoryList: [CategoryListData] = CategoryListData.dummy
    weak var coordinator: CategoryCoordinator?

    private lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(cell: CategoryCollectionViewCell.self)

        return collectionView
    }()

    private let categoryCountLabel: UILabel = {
        let label = UILabel()
        label.font = .font(.pretendardReular, ofSize: 13)
        label.text = "전체 0"
        label.textColor = UIColor.gray003

        return label
    }()

    // 📌 카테고리 추가 버튼은 재사용될 것 같아서 나중에 따로 빼면 좋을 것 같아요 !
    private let addButton: UIButton = {
        var configuration = UIButton.Configuration.plain()

        var container = AttributeContainer()
        container.font = .font(.pretendardSemibold, ofSize: 12)

        configuration.attributedTitle = AttributedString("카테고리 추가", attributes: container)

        configuration.baseForegroundColor = UIColor.purpleText
        configuration.image = UIImage(named: "category_add")

        configuration.background.cornerRadius = 23
        configuration.background.strokeColor = UIColor.purpleLight
        configuration.background.strokeWidth = 1

        configuration.imagePadding = 2
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 10, bottom: 3, trailing: 10)
        configuration.imagePlacement = .leading

        let button = UIButton(configuration: configuration, primaryAction: nil)

        return button
    }()

    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "iconBackBlack"), for: .normal)
        return button
    }()

    private let editButton: UIButton = {
        let button = UIButton()
        button.setTitle("수정", for: .normal)
        button.titleLabel?.font = .font(.pretendardMedium, ofSize: 14)
        button.setTitleColor(UIColor.gray003, for: .normal)
        return button
    }()

    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegation()
        setNavigationBar()
        bind()
    }
    
    override func render() {
        view.addSubViews([categoryCollectionView, categoryCountLabel, addButton])

        categoryCountLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(22)
            $0.leading.equalToSuperview().inset(18)
        }

        addButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(13)
            $0.leading.equalTo(categoryCountLabel.snp.trailing).offset(195)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(categoryCollectionView.snp.top).offset(-14)
        }

        categoryCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(56)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }

    override func configUI() {
        view.backgroundColor = .white
    }

    // MARK: - func
    private func setDelegation() {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
    }

    private func setNavigationBar() {
        title = "전체 카테고리"
        let font = UIFont.font(.pretendardBold, ofSize: 16)
        navigationController?.navigationBar.titleTextAttributes = [.font: font]

        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()

        navigationItem.leftBarButtonItem = makeBarButtonItem(with: backButton)
        navigationItem.rightBarButtonItem = makeBarButtonItem(with: editButton)
    }

    private func makeBarButtonItem(with button: UIButton) -> UIBarButtonItem {
        button.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
        return UIBarButtonItem(customView: button)
    }

    private func bind() {
        backButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.coordinator?.performTransition(to: .main)
            })
            .disposed(by: disposeBag)

        editButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.coordinator?.performTransition(to: .main)
            })
            .disposed(by: disposeBag)
    }
}

extension CategoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryCollectionView.dequeueReusableCell(forIndexPath: indexPath) as CategoryCollectionViewCell

        cell.update(data: categoryList[indexPath.row])
        return cell
    }
}

extension CategoryViewController: UICollectionViewDelegateFlowLayout {
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
