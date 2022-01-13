//
//  CategoryViewController.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/06.
//

import UIKit

import SnapKit

class CategoryViewController: UIViewController {

    // MARK: - Vars & Lets Part

    weak var coordinator: CategoryCoordinator?

    // MARK: - UI Component Part

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
        label.font = UIFont(name: "Pretendard-Regular", size: 13)
        label.text = "전체 0"
        label.textColor =  UIColor(red: 0.412, green: 0.412, blue: 0.412, alpha: 1)

        return label
    }()

    // 📌 카테고리 추가 버튼은 재사용될 것 같아서 나중에 따로 빼면 좋을 것 같아요 !
    private let addButton: UIButton = {
        var configuration = UIButton.Configuration.plain()

        var container = AttributeContainer()
        container.font = UIFont(name: "Pretendard-SemiBold", size: 12)

        configuration.attributedTitle = AttributedString("카테고리 추가", attributes: container)

        configuration.baseForegroundColor = UIColor(red: 0.488, green: 0.45, blue: 0.849, alpha: 1)
        configuration.image = UIImage(named: "category_add")

        configuration.background.cornerRadius = 23
        configuration.background.strokeColor = UIColor(red: 0.839, green: 0.836, blue: 1, alpha: 1)
        configuration.background.strokeWidth = 1

        configuration.imagePadding = 2
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 10, bottom: 3, trailing: 10)
        configuration.imagePlacement = .leading

        let button = UIButton(configuration: configuration, primaryAction: nil)

        return button
    }()


    // MARK: - Life Cycle Part
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegation()
        setLayouts()
    }

    // MARK: - Custom Method Part

    private func setDelegation() {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
    }

    // MARK: - @objc Function Part
}
// MARK: - Extension Part

extension CategoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryCollectionView.dequeueReusableCell(forIndexPath: indexPath) as CategoryCollectionViewCell

        return cell
    }
}

extension CategoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 📌 이부분 셀 width 비율에 맞춰서 해주고 싶은데 이 방법밖에 생각이 안나서 더 좋은 방법이 있다면 알려주세요!
        let widthRatio: CGFloat = 343/375
        return CGSize(width: collectionView.frame.width * widthRatio , height: 56)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension CategoryViewController {
    func setLayouts() {
        setViewHierarchies()
        setConstraints()
    }

    func setViewHierarchies() {
        view.addSubview(categoryCollectionView)
        view.addSubview(categoryCountLabel)
        view.addSubview(addButton)
    }

    func setConstraints() {
        categoryCountLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(114)
            $0.leading.equalToSuperview().inset(18)
        }

        addButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(105)
            $0.leading.equalTo(categoryCountLabel.snp.trailing).offset(195)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(categoryCollectionView.snp.top).offset(-14)
        }

        categoryCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(148)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }
}
