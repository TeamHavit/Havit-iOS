//
//  ContentsCollectionViewCell_sort3.swift
//  Havit
//
//  Created by 박예빈 on 2022/01/12.
//

import UIKit

import SnapKit

final class CategoryContents1xNCollectionViewCell: BaseCollectionViewCell {
    
    var didTapIsReadButton: ((Int, Int) -> Void)?
    
    // MARK: - property
    
     let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray000
        return view
    }()
    
     let mainImageView: UIImageView = {
       let imageView = UIImageView()
       imageView.image = ImageLiteral.imgContentsDummyImg1
       imageView.layer.cornerRadius = 4
       return imageView
   }()
   
     let alarmImageView: UIImageView = {
       let imageView = UIImageView()
       imageView.image = ImageLiteral.iconAlarmtagPuple
       return imageView
   }()
   
     var titleLabel: UILabel = {
       let label = UILabel()
       label.text = "슈슈슉 이것은 제목입니다 슈슉 슉슉 이것"
       label.font = UIFont.font(FontName.pretendardMedium, ofSize: CGFloat(15))
       label.textColor = .black
       label.numberOfLines = 2
       return label
   }()
   
     var subtitleLabel: UILabel = {
       let label = UILabel()
       label.text = "슈슈슉 이것은 제목입니다 슈슉 슉 슉 슈슉 슈슈슈슈슈슉 슉 슉"
       label.font = UIFont.font(FontName.pretendardReular, ofSize: CGFloat(9))
       label.textColor = .gray003
       label.textColor = .black
       return label
   }()
   
     var dateLabel: UILabel = {
       let label = UILabel()
       label.text = "2021. 11. 24 · "
       label.font = UIFont.font(FontName.pretendardReular, ofSize: CGFloat(9))
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
   
    var isReadButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiteral.btnContentsUnread, for: .normal)
        return button
    }()
   
     var alarmLabel: UILabel = {
       let label = UILabel()
       label.text = "2021. 11. 17 오전 12:30 알림 예정"
       label.font = UIFont.font(FontName.pretendardSemibold, ofSize: CGFloat(9))
       label.textColor = .havitPurple
       return label
   }()
    
    private var contentId: Int?
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        bind()
    }
    
    override func prepareForReuse() {
        mainImageView.image = nil
        titleLabel.text = ""
        subtitleLabel.text = ""
        dateLabel.text = ""
        linkLabel.text = ""
        alarmLabel.text = ""
    }
    
    override func render() {
        contentView.addSubViews([mainImageView, titleLabel, subtitleLabel, dateLabel, linkLabel, alarmLabel, moreButton, isReadButton, borderView])
        mainImageView.addSubview(alarmImageView)
        
        setupImageSectionLayout()
        setupTitleSectionLayout()
    }
    
    func setupImageSectionLayout() {
        mainImageView.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(17)
            $0.leading.equalTo(contentView).offset(16)
            $0.trailing.equalTo(contentView).inset(16)
            $0.height.equalTo(184)
        }
        
        alarmImageView.snp.makeConstraints {
            $0.leading.equalTo(mainImageView)
            $0.top.equalTo(mainImageView)
            $0.width.height.equalTo(40)
        }
    }
    
    func setupTitleSectionLayout() {
        moreButton.snp.makeConstraints {
            $0.top.equalTo(mainImageView.snp.bottom).offset(15)
            $0.trailing.equalTo(contentView).inset(16)
            $0.width.equalTo(16)
            $0.height.equalTo(16)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(contentView).offset(16)
            $0.top.equalTo(mainImageView.snp.bottom).offset(15)
            $0.trailing.equalTo(moreButton.snp.leading).inset(18)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(contentView).offset(16)
            $0.top.equalTo(titleLabel.snp.bottom).offset(9)
        }
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(contentView).offset(16)
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(9)
            $0.height.equalTo(10)
        }

        linkLabel.snp.makeConstraints {
            $0.leading.equalTo(dateLabel.snp.trailing).offset(3)
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(9)
            $0.trailing.equalTo(moreButton.snp.leading).inset(60)
            $0.height.equalTo(10)
        }
        
        alarmLabel.snp.makeConstraints {
            $0.leading.equalTo(contentView).offset(16)
            $0.top.equalTo(dateLabel.snp.bottom).offset(7)
            $0.trailing.equalTo(isReadButton.snp.leading).inset(1)
            $0.width.equalTo(182)
            $0.height.equalTo(13)
        }
        
        isReadButton.snp.makeConstraints {
            $0.trailing.equalTo(contentView).inset(15)
            $0.bottom.equalTo(borderView.snp.top).inset(4)
            $0.width.equalTo(31)
            $0.height.equalTo(42)
        }
        
        borderView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(contentView)
            $0.height.equalTo(1)
        }
    }
    
    // MARK: - func
    
    private func bind() {
        isReadButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                if let indexPath = self?.getCollectionCellIndexPath(),
                   let contentId = self?.contentId {
                    self?.didTapIsReadButton?(contentId, indexPath)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func getCollectionCellIndexPath() -> Int {
        guard
            let superView = self.superview as? UICollectionView,
            let indexPath = superView.indexPath(for: self)?.row
        else { return -1 }

        return indexPath
    }
    
    func update(content: Content) {
        contentId = content.id
        
        if let imageUrl = content.image,
           let url = URL(string: imageUrl) {
            mainImageView.kf.setImage(with: url)
        }
        
        if let isNotified = content.isNotified,
           isNotified {
            alarmImageView.isHidden = false
        }
        
        if let isSeen = content.isSeen,
           isSeen {
            isReadButton.setImage(ImageLiteral.btnContentsRead, for: .normal)
        }
        
        if let createdAt = content.createdAt {
            let dateFormat = changeDateFormat(with: createdAt)
            dateLabel.text = "\(dateFormat) •"
        }
        
        if let notificatedTime = content.notificationTime,
           notificatedTime != ""{
            alarmLabel.text = changeDateAlarmFormat(with: notificatedTime)
        }
        
        titleLabel.text = content.title
        subtitleLabel.text = content.contentDescription
        linkLabel.text = content.url
    }
    
    private func changeDateFormat(with date: String) -> String {
        let dateArray = date.components(separatedBy: " ")
        let dateComponent = dateArray[0]
        let dateComponentWithDot = dateComponent.replacingOccurrences(of: "-", with: ". ")
        return dateComponentWithDot
    }
    
    private func changeDateAlarmFormat(with date: String) -> String {
        let dateArray = date.components(separatedBy: " ")
        let dateComponent = dateArray[0]
        let timeComponent = dateArray[1]
        let dateComponentWithDot = dateComponent.replacingOccurrences(of: "-", with: ". ")
        let separatedTime = divideTime(with: timeComponent)
        return "\(dateComponentWithDot) \(separatedTime)"
    }
    
    private func divideTime(with time: String) -> String {
        let timeArray = time.components(separatedBy: ":")
        if let hour = Int(timeArray[0]) {
            if hour < 12 {
                return "오전 \(time) 알림 예정"
            } else {
                return "오후 \(time) 알림 예정"
            }
        }
        
        return ""
    }
}
