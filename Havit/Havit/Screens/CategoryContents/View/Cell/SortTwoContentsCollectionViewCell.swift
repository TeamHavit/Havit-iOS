//
//  ContentsCollectionViewCell_sort2.swift
//  Havit
//
//  Created by 박예빈 on 2022/01/12.
//

import UIKit

import SnapKit

final class SortTwoContentsCollectionViewCell: UICollectionViewCell {
    
    var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage()
        return imageView
    }()
    
    var alarmImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage()
        return imageView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "슈슈슉 이것은 제목입니다 슈슉 슉슉 이것"
        label.numberOfLines = 0
        return label
    }()
    
    var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "슈슈슉 이것은 제목입니다 슈슉 슉"
        return label
    }()
    
    var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2021. 11. 24"
        return label
    }()
    
    var linkLabel: UILabel = {
        let label = UILabel()
        label.text = "www.beansbin.oopy.io"
        return label
    }()
    
    var moreButton: UIButton = {
        let button = UIButton()
        button.setTitle("...", for: .normal)
        return button
    }()
    
    var isReadImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage()
        return imageView
    }()
    
    var alarmLabel: UILabel = {
        let label = UILabel()
        label.text = "2021. 11. 17 오전 12:30 알림 예정"
        return label
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setCell()
        setAutoLayouts()
    }
    
    func setCell() {
        contentView.addSubview(mainImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(linkLabel)
        contentView.addSubview(alarmLabel)
        mainImageView.addSubview(alarmImageView)
        contentView.addSubview(moreButton)
        contentView.addSubview(isReadImageView)
    }
    
    func setAutoLayouts() {
        mainImageView.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(16)
            $0.leading.equalTo(contentView).offset(0)
            $0.trailing.equalTo(contentView).offset(0)
            $0.height.equalTo(109)
        }
        
        alarmImageView.snp.makeConstraints {
            $0.leading.equalTo(mainImageView).offset(0)
            $0.top.equalTo(mainImageView).offset(0)
            $0.width.equalTo(28)
            $0.height.equalTo(28)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(contentView).offset(0)
            $0.top.equalTo(mainImageView).offset(10)
            $0.trailing.equalTo(moreButton).offset(0)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.leading.equalTo(contentView).offset(0)
            $0.top.equalTo(titleLabel).offset(5)
        }
        
        linkLabel.snp.makeConstraints {
            $0.leading.equalTo(contentView).offset(0)
            $0.top.equalTo(subtitleLabel).offset(8)
        }
        
        moreButton.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel).offset(9)
            $0.trailing.equalTo(contentView).offset(-5)
            $0.width.equalTo(16)
            $0.height.equalTo(10)
        }
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(contentView).offset(0)
            $0.top.equalTo(linkLabel).offset(5)
        }
        
        alarmLabel.snp.makeConstraints {
            $0.leading.equalTo(mainImageView).offset(0)
            $0.top.equalTo(mainImageView).offset(0)
        }
        
        isReadImageView.snp.makeConstraints {
            $0.trailing.equalTo(contentView).offset(0)
            $0.bottom.equalTo(mainImageView).offset(-5)
            $0.width.equalTo(31)
            $0.height.equalTo(42)
        }
    }
}
