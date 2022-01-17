//
//  CategoryListTableViewCell.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/16.
//

import UIKit

import SnapKit

final class CategoryListTableViewCell: BaseTableViewCell {
    
    // MARK: - property
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .font(.pretendardSemibold, ofSize: 17)
        label.textColor = .primaryBlack
        label.text = "홍승현님의 카테고리"
        return label
    }()
    private let overallButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .font(.pretendardReular, ofSize: 12)
        button.setTitle("전체보기", for: .normal)
        button.setTitleColor(.gray003, for: .normal)
        return button
    }()
    private lazy var categoryCollectionView: UICollectionView = {
        let flowLayout = MainCategoryCollectionViewFlowLayout(row: 2, column: 3)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 5
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.decelerationRate = .fast
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(cell: CategoryListCollectionViewCell.self)
        return collectionView
    }()
    private let pageControl = MainCategoryPageControl()
    var categorys: [String] = ["카테고리1", "카테고리2", "카테고리3", "카테고리4", "카테고리5", "카테고리6", "카테고리7", "카테고리8", "카테고리1", "카테고리2", "카테고리3", "카테고리4", "카테고리5", "카테고리6", "카테고리7", "카테고리8"]
    
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
        addSubViews([titleLabel, overallButton, categoryCollectionView, pageControl])
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        
        overallButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(-4)
            $0.trailing.equalToSuperview().inset(19)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(-10)
        }
        
        categoryCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(348)
        }
        
        pageControl.snp.makeConstraints {
            $0.top.equalTo(categoryCollectionView.snp.bottom).offset(9)
            $0.bottom.equalToSuperview().inset(30)
            $0.centerX.equalToSuperview()
        }
    }
    
    override func configUI() {
        backgroundColor = .white
        
        pageControl.pages = 2
    }
}

extension CategoryListTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if categorys.count % 6 != 0 {
            return categorys.count + 1 + ((categorys.count + 1) % 6)
        }
        return categorys.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CategoryListCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        
        if categorys.count >= indexPath.item {
            switch indexPath.item {
            case .zero:
                cell.backgroundColor = .caution
                cell.updateCategory(image: UIImage(), title: "모든 콘텐츠", contentCount: 90)
            default:
                cell.updateCategory(image: ImageLiteral.imgCategoryNone, title: categorys[indexPath.item - 1], contentCount: 27)
            }
            return cell
        }
        
        cell.backgroundColor = .clear
        return cell
    }
}

extension CategoryListTableViewCell: UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let layout = categoryCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        let pageWidth = layout.collectionView?.frame.width ?? 0
        var offsetPoint = targetContentOffset.pointee
        var selectedIndex = (offsetPoint.x + scrollView.contentInset.left) / pageWidth

        if scrollView.contentOffset.x > targetContentOffset.pointee.x {
            selectedIndex = floor(selectedIndex)
        } else if scrollView.contentOffset.x < targetContentOffset.pointee.x {
            selectedIndex = ceil(selectedIndex)
        } else {
            selectedIndex = round(selectedIndex)
        }
        
        pageControl.selectedPage = Int(selectedIndex)
        
        offsetPoint = CGPoint(x: selectedIndex * pageWidth - scrollView.contentInset.left,
                              y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offsetPoint
    }
}
