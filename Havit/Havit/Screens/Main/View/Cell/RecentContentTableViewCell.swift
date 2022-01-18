//
//  RecentContentTableViewCell.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/17.
//

import UIKit

import SnapKit

final class RecentContentTableViewCell: BaseTableViewCell {
    
    private enum Size {
        static let cellWidth: Int = { () -> Int in
            let screenWidth = UIScreen.main.bounds.size.width
            let leftInset = 16
            let rightInset = 229
            return Int(screenWidth) - leftInset - rightInset
        }()
        static let cellHeight = 171
    }
    
    // MARK: - property
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "최근 저장 콘텐츠"
        label.textColor = .primaryBlack
        label.font = .font(.pretendardSemibold, ofSize: 17)
        return label
    }()
    private let overallButton: UIButton = {
        let button = UIButton()
        button.setTitle("더보기", for: .normal)
        button.setTitleColor(.gray003, for: .normal)
        button.titleLabel?.font = .font(.pretendardReular, ofSize: 12)
        return button
    }()
    private lazy var contentCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 12, left: 16, bottom: 40, right: 16)
        flowLayout.itemSize = CGSize(width: Size.cellWidth, height: Size.cellHeight)
        flowLayout.minimumInteritemSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(cell: RecentContentCollectionViewCell.self)
        return collectionView
    }()
    
    private let dummyContents: [String] = ["헤더 제목", "제목 헤더", "헤더를 입력하세요.", "헤더 입력하세요.", "입력 헤더", "헤더 입력"]
    
    override func render() {
        contentView.addSubViews([titleLabel, overallButton, contentCollectionView])
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(42)
            $0.leading.equalToSuperview().inset(16)
        }
        
        overallButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.top).inset(-4)
            $0.trailing.equalToSuperview().inset(17)
        }
        
        contentCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(223)
        }
    }
}

extension RecentContentTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummyContents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: RecentContentCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.update(title: dummyContents[indexPath.row], date: "2022.01.19", categoryTitle: "해빗화이팅")
        return cell
    }
}
