//
//  RecommendSiteCollectionViewCell.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/17.
//

import UIKit

import SnapKit

final class RecommendSiteCollectionViewCell: BaseCollectionViewCell {
    
    private enum Size {
        static let sideMargin: CGFloat = 54.0
    }
    
    // MARK: - property
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .gray002
        imageView.layer.cornerRadius = (self.frame.width - Size.sideMargin) / 2
        return imageView
    }()
    private let siteTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .font(.pretendardMedium, ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .font(.pretendardReular, ofSize: 10)
        label.textColor = .gray003
        label.textAlignment = .center
        return label
    }()
    
    override func render() {
        contentView.addSubViews([profileImageView, siteTitleLabel, subTitleLabel])
        
        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(17)
            $0.leading.trailing.equalToSuperview().inset(27)
            $0.height.equalTo(profileImageView.snp.width).multipliedBy(1.0)
        }
        
        siteTitleLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview().inset(5)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(siteTitleLabel.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(5)
        }
    }
    
    override func configUI() {
        backgroundColor = .gray000
    }
    
    func updateSite(title: String, image: UIImage, type: String, category: String) {
        profileImageView.image = image
        siteTitleLabel.text = title
        subTitleLabel.text = "\(type) / \(category)"
    }
}
