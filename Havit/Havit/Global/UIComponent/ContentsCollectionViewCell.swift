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
    
     let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiteral.imgContentsDummyImg1
        return imageView
    }()
    
     let alarmImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiteral.iconAlarmtagPuple
        imageView.layer.cornerRadius = 4
        return imageView
    }()
    
     var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "슈슈슉 이것은 제목입니다 슈슉 슉슉 이것"
        label.font = UIFont.font(FontName.pretendardMedium, ofSize: 15)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
     var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "슈슈슉 이것은 제목입니다 슈슉 슉 슉 슈슉 슈슈슈슈슈슉 슉 슉"
        label.font = UIFont.font(FontName.pretendardReular, ofSize: 9)
        label.textColor = .gray003
        return label
    }()
    
     var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2021. 11. 24 ·"
        label.font = UIFont.font(FontName.pretendardReular, ofSize: 9)
        label.textColor = .gray002
        return label
    }()
    
     var linkLabel: UILabel = {
        let label = UILabel()
        label.text = "www.beansbin.oopy.ioooooooooooo"
        label.font = UIFont.font(FontName.pretendardReular, ofSize: CGFloat(9))
        label.textColor = .gray002
        return label
    }()
    
     var moreButton: UIButton = {
         let button = UIButton()
         button.setImage(ImageLiteral.btnMore, for: .normal)
         return button
    }()
    
    private var isReadButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiteral.btnContentsRead, for: .normal)
        return button
    }()
    
     var alarmLabel: UILabel = {
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
        bind()
    }
    
    override func render() {
        contentView.addSubViews([mainImageView, titleLabel, subtitleLabel, dateLabel, linkLabel, alarmLabel, moreButton, isReadButton])
        mainImageView.addSubview(alarmImageView)
        
        mainImageView.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(15)
            $0.leading.equalTo(contentView).offset(16)
            $0.width.height.equalTo(108)
        }
        
        isReadButton.snp.makeConstraints {
            $0.trailing.equalTo(contentView).inset(16)
            $0.bottom.equalTo(contentView).inset(15)
            $0.width.equalTo(31)
            $0.height.equalTo(42)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(mainImageView.snp.trailing).offset(12)
            $0.top.equalTo(mainImageView)
            $0.trailing.equalTo(moreButton.snp.leading).offset(-17)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.leading.equalTo(mainImageView.snp.trailing).offset(12)
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
            $0.trailing.equalTo(contentView).inset(49)
        }
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(mainImageView.snp.trailing).offset(12)
            $0.bottom.equalToSuperview().inset(38)
            $0.width.equalTo(55)
        }
        
        linkLabel.snp.makeConstraints {
            $0.leading.equalTo(dateLabel.snp.trailing)
            $0.top.equalTo(dateLabel)
            $0.trailing.equalTo(contentView).inset(49)
        }
        
        alarmLabel.snp.makeConstraints {
            $0.leading.equalTo(mainImageView.snp.trailing).offset(12)
            $0.bottom.equalToSuperview().inset(22)
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
    
    // MARK: - func
    
    private func bind() {
        isReadButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                let isReadArticle = self?.isReadButton.imageView?.image == ImageLiteral.btnContentsRead
                self?.isReadButton.setImage(isReadArticle ? ImageLiteral.btnContentsUnread : ImageLiteral.btnContentsRead, for: .normal)
            })
            .disposed(by: disposeBag)
    }
}
