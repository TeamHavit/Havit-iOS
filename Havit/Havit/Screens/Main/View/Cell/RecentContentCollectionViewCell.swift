//
//  RecentContentCollectionViewCell.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/17.
//

import UIKit

final class RecentContentCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - property
    
    private let contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = ImageLiteral.imgDummyContent
        imageView.layer.cornerRadius = 6
        return imageView
    }()
    private lazy var categoryTagButton: UIButton = {
        var container = AttributeContainer()
        container.font = .font(.pretendardReular, ofSize: 10)
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 5, bottom: 4, trailing: 5)
        configuration.baseBackgroundColor = .purple001
        configuration.baseForegroundColor = .purpleText
        configuration.attributedTitle = AttributedString("카테고리 없음", attributes: container)
        configuration.image = UIImage(systemName: "circle.fill")
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 10)
        configuration.imagePadding = 4
        let button = UIButton(configuration: configuration)
        return button
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .font(.pretendardMedium, ofSize: 14)
        label.textColor = .primaryBlack
        label.numberOfLines = 2
        label.lineBreakStrategy = .hangulWordPriority
        label.text = "헤더입니다. 헤헤헤헤 헤더 입니다. 헤더 헤더인디요권지용"
        return label
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .font(.pretendardReular, ofSize: 9)
        label.textColor = .gray002
        label.text = "2021.02.04"
        return label
    }()
    private var configuration = UIButton.Configuration.filled()
    
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
}
