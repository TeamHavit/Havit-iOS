//
//  RecentContentCollectionViewCell.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/17.
//

import UIKit

import SnapKit

final class RecentContentCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - property
    
    private let contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .gray001
        imageView.layer.cornerRadius = 6
        return imageView
    }()
    private lazy var categoryTagButton: UIButton = {
        buttonConfiguration.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 5, bottom: 4, trailing: 5)
        buttonConfiguration.baseBackgroundColor = .purple001
        buttonConfiguration.baseForegroundColor = .purpleText
        buttonConfiguration.attributedTitle = AttributedString("카테고리 없음", attributes: buttonContainer)
        buttonConfiguration.image = UIImage(systemName: "circle.fill")
        buttonConfiguration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 10)
        buttonConfiguration.imagePadding = 4
        let button = UIButton(configuration: buttonConfiguration)
        return button
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .font(.pretendardMedium, ofSize: 14)
        label.textColor = .primaryBlack
        label.numberOfLines = 2
        label.lineBreakStrategy = .hangulWordPriority
        return label
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .font(.pretendardReular, ofSize: 9)
        label.textColor = .gray002
        return label
    }()
    private var buttonConfiguration = UIButton.Configuration.filled()
    private var buttonContainer = AttributeContainer([.font: UIFont.font(.pretendardReular, ofSize: 10)])
    
    override func prepareForReuse() {
        contentImageView.image = nil
        titleLabel.text = ""
        dateLabel.text = ""
        buttonConfiguration.attributedTitle = AttributedString("카테고리 없음", attributes: buttonContainer)
        categoryTagButton.configuration = buttonConfiguration
    }
    
    override func render() {
        contentView.addSubViews([contentImageView, categoryTagButton,
                                 titleLabel, dateLabel])
        
        contentImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(82)
        }
        
        categoryTagButton.snp.makeConstraints {
            $0.top.equalTo(contentImageView.snp.bottom).offset(8)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview().priority(.low)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(categoryTagButton.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview()
        }
    }
    
    // MARK: - func
    
    func update(title: String, date: String, categoryTitle: String) {
        titleLabel.text = title
        dateLabel.text = date
        buttonConfiguration.attributedTitle = AttributedString(categoryTitle, attributes: buttonContainer)
        categoryTagButton.configuration = buttonConfiguration
    }
}
