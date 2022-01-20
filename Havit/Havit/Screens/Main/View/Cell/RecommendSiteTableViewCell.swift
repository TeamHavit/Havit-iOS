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
            let sideMargin = 16
            let rowCount = 3
            return (Int(width) - spacing * 2 - sideMargin * 2) / rowCount
        }()
        static let cellHeight = 141
    }
    
    var didTapSiteSection: ((String) -> Void)?
    
    // MARK: - property
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .whiteGray
        return view
    }()
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
        label.textColor = .gray003
        return label
    }()
    private lazy var siteCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 30, left: 16, bottom: 0, right: 16)
        flowLayout.itemSize = CGSize(width: Size.cellWidth, height: Size.cellHeight)
        flowLayout.minimumLineSpacing = 11
        flowLayout.minimumInteritemSpacing = 11
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(cell: RecommendSiteCollectionViewCell.self)
        return collectionView
    }()
    var sites: [Site] = []
    
    override func render() {
        contentView.addSubViews([separatorView, titleLabel, subtitleLabel, siteCollectionView])
        
        separatorView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(10)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom).offset(33)
            $0.leading.equalToSuperview().inset(16)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().inset(16)
        }
        
        siteCollectionView.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(727)
        }
    }
    
    override func configUI() {
        selectionStyle = .none
    }
}

extension RecommendSiteTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: RecommendSiteCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.update(sites: sites[indexPath.item])
        return cell
    }
}

extension RecommendSiteTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let siteUrl = sites[indexPath.item].url else { return }
        didTapSiteSection?(siteUrl)
    }
}
