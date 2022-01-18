//
//  ContentsCollectionViewCell.swift
//  Havit
//
//  Created by 박예빈 on 2022/01/12.
//

import UIKit

import RxSwift
import SnapKit

final class ContentsCollectionViewCell: BaseCollectionViewCell {
    
     private let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "contentsDummyImg1")
        return imageView
    }()
    
     private let alarmImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "iconAlarmtagPuple")
        return imageView
    }()
    
     private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "슈슈슉 이것은 제목입니다 슈슉 슉슉 이것"
        label.font = UIFont.font(FontName.pretendardMedium, ofSize: CGFloat(15))
        label.textColor = .gray003
        label.numberOfLines = 2
        return label
    }()
    
     private var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "슈슈슉 이것은 제목입니다 슈슉 슉 슉 슈슉 슈슈슈슈슈슉 슉 슉"
        label.font = UIFont.font(FontName.pretendardReular, ofSize: CGFloat(9))
        label.textColor = .gray003
        label.textColor = .black
        return label
    }()
    
     private var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2021. 11. 24 · "
        label.font = UIFont.font(FontName.pretendardReular, ofSize: CGFloat(9))
        label.textColor = .gray002
        return label
    }()
    
     private var linkLabel: UILabel = {
        let label = UILabel()
        label.text = "www.beansbin.oopy.ioooooooooooo"
        label.font = UIFont.font(FontName.pretendardReular, ofSize: CGFloat(9))
        label.textColor = .gray002
        return label
    }()
    
     private var moreButton: UIButton = {
         let button = UIButton()
         button.setImage(UIImage(named: "btnMore"), for: .normal)
         return button
    }()
    
     private var isReadImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "btnContentsRead")
        return imageView
    }()
    
     private var alarmLabel: UILabel = {
        let label = UILabel()
        label.text = "2021. 11. 17 오전 12:30 알림 예정"
        label.font = UIFont.font(FontName.pretendardSemibold, ofSize: CGFloat(9))
        label.textColor = .havitPurple
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
            $0.top.equalTo(contentView).offset(15)
            $0.leading.equalTo(contentView).offset(16)
            $0.width.height.equalTo(108)
        }
        
        isReadImageView.snp.makeConstraints {
            $0.trailing.equalTo(contentView).inset(16)
            $0.bottom.equalTo(contentView).inset(15)
            $0.width.equalTo(31)
            $0.height.equalTo(42)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(mainImageView.snp.trailing).offset(12)
            $0.top.equalTo(mainImageView)
            $0.trailing.equalTo(moreButton.snp.leading).offset(17)
        }

        subtitleLabel.snp.makeConstraints {
            $0.leading.equalTo(mainImageView.snp.trailing).offset(12)
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
            $0.trailing.equalTo(contentView).inset(49)
        }

        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(mainImageView.snp.trailing).offset(12)
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(15)
            $0.width.equalTo(47)
        }

        linkLabel.snp.makeConstraints {
            $0.leading.equalTo(dateLabel.snp.trailing)
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(15)
            $0.trailing.equalTo(contentView).inset(49)
        }

        alarmLabel.snp.makeConstraints {
            $0.leading.equalTo(mainImageView.snp.trailing).offset(12)
            $0.top.equalTo(dateLabel.snp.bottom).offset(8)
        }

        alarmImageView.snp.makeConstraints {
            $0.leading.equalTo(mainImageView)
            $0.top.equalTo(mainImageView)
            $0.width.height.equalTo(40)
        }

        moreButton.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(15)
            $0.trailing.equalTo(contentView).inset(16)
            $0.width.equalTo(16)
            $0.height.equalTo(10)
        }
    }
}
