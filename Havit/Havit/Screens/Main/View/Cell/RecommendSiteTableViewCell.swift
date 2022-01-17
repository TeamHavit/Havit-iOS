//
//  RecommendSiteTableViewCell.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/17.
//

import UIKit

import SnapKit

final class RecommendSiteTableViewCell: BaseTableViewCell {
    
    private enum Size {
        static let cellWidth = { () -> Int in
            let width = UIScreen.main.bounds.size.width
            let spacing = 11
            return Int(width) - spacing * 2
        }()
        static let cellHeight = 141
    }
    
    // MARK: - property
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "오늘의 추천 사이트"
        label.font = .font(.pretendardSemibold, ofSize: 17)
        label.textColor = .primaryBlack
        return label
    }()
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "다양한 사이트에서 해빗 할 콘텐츠를 탐색해 보세요"
        label.font = .font(.pretendardReular, ofSize: 14)
        label.textColor = .havitGray
        return label
    }()
    private lazy var siteCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 30, left: 16, bottom: 0, right: 16)
        flowLayout.itemSize = CGSize(width: Size.cellWidth, height: Size.cellHeight)
        flowLayout.minimumLineSpacing = 11
        flowLayout.minimumInteritemSpacing = 11
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        return collectionView
    }()
    
}
