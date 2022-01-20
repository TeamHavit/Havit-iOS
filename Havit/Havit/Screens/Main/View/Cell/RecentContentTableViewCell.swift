//
//  RecentContentTableViewCell.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/17.
//

import UIKit

import RxCocoa
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
    
    var didTapOverallButton: (() -> Void)?
    
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
    private let recentEmptyView = MainRecentContentEmptyView()
    
    var contents: [Content] = []
    
    // MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        bind()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func render() {
        contentView.addSubViews([titleLabel, overallButton])
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(42)
            $0.leading.equalToSuperview().inset(16)
        }
        
        overallButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.top).inset(-4)
            $0.trailing.equalToSuperview().inset(17)
        }
    }
    
    override func configUI() {
        selectionStyle = .none
    }
    
    // MARK: - func
    
    private func bind() {
        overallButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.didTapOverallButton?()
            })
            .disposed(by: disposeBag)
    }
    
    func setupContentPartLayout(with contents: [Content]) {
        let hasContent = !contents.isEmpty
        
        if hasContent {
            if contentView.subviews.contains(recentEmptyView) {
                recentEmptyView.removeFromSuperview()
            }
            contentView.addSubView(contentCollectionView)
            contentCollectionView.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom)
                $0.leading.trailing.bottom.equalToSuperview()
                $0.height.equalTo(223).priority(.high)
            }
        } else {
            if contentView.subviews.contains(contentCollectionView) {
                contentCollectionView.removeFromSuperview()
            }
            contentView.addSubView(recentEmptyView)
            recentEmptyView.snp.makeConstraints {
                $0.top.equalTo(titleLabel.snp.bottom).offset(14)
                $0.leading.trailing.equalToSuperview().inset(16)
                $0.bottom.equalToSuperview().inset(37)
                $0.height.equalTo(98)
            }
        }
    }
}

extension RecentContentTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: RecentContentCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.update(content: contents[indexPath.item])
        return cell
    }
}
