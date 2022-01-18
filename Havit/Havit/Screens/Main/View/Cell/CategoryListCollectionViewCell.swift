//
//  CategoryListCollectionViewCell.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/16.
//

import UIKit

import SnapKit

final class CategoryListCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - property
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .font(.pretendardMedium, ofSize: 16)
        label.textColor = .primaryBlack
        return label
    }()
    private let storedContentLabel: UILabel = {
        let label = UILabel()
        label.font = .font(.pretendardReular, ofSize: 12)
        label.textColor = .gray003
        return label
    }()
    
    override func prepareForReuse() {
        backgroundImageView.image = nil
        iconImageView.image = nil
        titleLabel.text = ""
        storedContentLabel.text = ""
        backgroundColor = .purpleCategory
    }
    
    override func render() {
        contentView.addSubViews([backgroundImageView, iconImageView, titleLabel, storedContentLabel])
        
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        iconImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(11)
            $0.width.height.equalTo(42)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(54)
            $0.leading.trailing.equalToSuperview().inset(18)
        }
        
        storedContentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(3)
            $0.leading.equalTo(titleLabel)
        }
    }
    
    override func configUI() {
        clipsToBounds = true
        layer.cornerRadius = 6
        backgroundColor = .purpleCategory
    }
    
    // MARK: - func
    
    func updateCategory(image: UIImage, title: String, contentCount: Int) {
        iconImageView.image = image
        titleLabel.text = title
        storedContentLabel.text = "저장 콘텐츠 \(contentCount)"
        storedContentLabel.applyColor(to: contentCount.description, with: .havitPurple)
    }
}
