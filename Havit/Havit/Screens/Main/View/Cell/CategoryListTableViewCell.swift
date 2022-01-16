//
//  CategoryListTableViewCell.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/16.
//

import UIKit

import SnapKit

final class CategoryListTableViewCell: BaseTableViewCell {
    
    private enum Size {
        static let cellHeight: CGFloat = 106
        static let cellWidth: CGFloat = {
            let margin = 16 * 2
            let spacing = 5
            let width = (Int(UIScreen.main.bounds.size.width) - margin - spacing) / 2
            return CGFloat(width)
        }()
    }
    
    // MARK: - property
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .font(.pretendardSemibold, ofSize: 17)
        label.textColor = .primaryBlack
        return label
    }()
    private let overallButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .font(.pretendardReular, ofSize: 12)
        button.setTitleColor(.gray003, for: .normal)
        return button
    }()
    private lazy var categoryCollectionView: UICollectionView = {
        let flowLayout = MainCategoryCollectionViewFlowLayout(row: 2, column: 1)
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.decelerationRate = .fast
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.register(cell: CategoryListCollectionViewCell.self)
        return collectionView
    }()
    var categorys: [String] = ["카테고리1", "카테고리2", "카테고리3", "카테고리4", "카테고리5", "카테고리6", "카테고리7", "카테고리8"]
    
    // MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func render() {
        sendSubviewToBack(contentView)
        addSubViews([titleLabel, overallButton, categoryCollectionView])
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        
        overallButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(2)
            $0.trailing.equalToSuperview().inset(19)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(-10)
        }
        
        categoryCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(348)
            $0.bottom.equalToSuperview()
        }
    }
    
    override func configUI() {
        backgroundColor = .white
    }
}

extension CategoryListTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if categorys.count % 6 != 0 {
            return categorys.count + (categorys.count % 6)
        }
        return categorys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if categorys.count > indexPath.item {
            let cell: CategoryListCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            cell.titleLabel.text = categorys[indexPath.item]
            return cell
        }
        
        let cell: CategoryListCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.backgroundColor = .clear
        return cell
    }
}
