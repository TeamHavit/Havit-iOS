//
//  ContentsCollectionViewCell_sort3.swift
//  Havit
//
//  Created by 박예빈 on 2022/01/12.
//

import UIKit

import SnapKit

final class SortThreeContentsCollectionViewCell: BaseCollectionViewCell {
    
    private var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage()
        return imageView
    }()
    
    private var alarmImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage()
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "슈슈슉 이것은 제목입니다 슈슉 슉슉 이것"
        label.numberOfLines = 0
        return label
    }()
    
    private var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "슈슈슉 이것은 제목입니다 슈슉 슉"
        return label
    }()
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2021. 11. 24"
        return label
    }()
    
    private var linkLabel: UILabel = {
        let label = UILabel()
        label.text = "www.beansbin.oopy.io"
        return label
    }()
    
    private var moreButton: UIButton = {
        let button = UIButton()
        button.setTitle("...", for: .normal)
        return button
    }()
    
    private var isReadImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage()
        return imageView
    }()
    
    private var alarmLabel: UILabel = {
        let label = UILabel()
        label.text = "2021. 11. 17 오전 12:30 알림 예정"
        return label
    }()
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    override func render() {
        contentView.addSubViews([mainImageView, titleLabel, subtitleLabel, dateLabel, linkLabel, alarmLabel, moreButton, isReadImageView])
        mainImageView.addSubview(alarmImageView)
        
        mainImageView.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(17)
            $0.leading.equalTo(contentView).offset(16)
            $0.trailing.equalTo(contentView).offset(-16)
            $0.height.equalTo(184)
        }
        
        alarmImageView.snp.makeConstraints {
            $0.leading.equalTo(mainImageView)
            $0.top.equalTo(mainImageView)
            $0.width.equalTo(28)
            $0.height.equalTo(28)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(contentView).offset(17)
            $0.top.equalTo(mainImageView).offset(15)
            $0.trailing.equalTo(moreButton).offset(-18)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.leading.equalTo(contentView).offset(17)
            $0.top.equalTo(titleLabel).offset(3)
            $0.trailing.equalTo(titleLabel)
        }
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(contentView).offset(17)
            $0.top.equalTo(linkLabel).offset(9)
        }
        
        linkLabel.snp.makeConstraints {
            $0.leading.equalTo(dateLabel)
            $0.top.equalTo(subtitleLabel).offset(9)
        }
        
        moreButton.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel).offset(15)
            $0.trailing.equalTo(contentView).offset(-20)
            $0.width.equalTo(16)
            $0.height.equalTo(10)
        }
        
        alarmLabel.snp.makeConstraints {
            $0.leading.equalTo(mainImageView)
            $0.top.equalTo(mainImageView)
        }
        
        isReadImageView.snp.makeConstraints {
            $0.trailing.equalTo(contentView).offset(-16)
            $0.bottom.equalTo(mainImageView).offset(-4)
            $0.width.equalTo(31)
            $0.height.equalTo(42)
        }
    }
}
