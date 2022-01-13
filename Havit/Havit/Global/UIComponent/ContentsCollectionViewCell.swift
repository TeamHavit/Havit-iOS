//
//  ContentsCollectionViewCell.swift
//  Havit
//
//  Created by 박예빈 on 2022/01/12.
//

import UIKit
import SnapKit
import RxSwift

class ContentsCollectionViewCell: UICollectionViewCell {
    static var cellID = "ContentsCollectionViewCell"
    
    var mainImgView: UIImageView!
    var alarmImgView: UIImageView!
    var titleLabel: UILabel!
    var subtitleLabel: UILabel!
    var dateAndLinkLabel: UILabel!
    var moreButton: UIButton!
    var isReadImgView: UIImageView!
    var alarmLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpCell()
        setAutoLayouts()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUpCell()
        setAutoLayouts()
    }
    
    func setUpCell() {
        mainImgView = {
            let imgView = UIImageView()
            imgView.image = UIImage()
            
            return imgView
        }()
        contentView.addSubview(mainImgView)
        
        titleLabel = {
            let label = UILabel()
            label.text = "슈슈슉 이것은 제목입니다 슈슉 슉슉 이것"
            label.numberOfLines = 0
            
            return label
        }()
        contentView.addSubview(titleLabel)
        
        subtitleLabel = {
            let label = UILabel()
            label.text = "슈슈슉 이것은 제목입니다 슈슉 슉"
            
            return label
        }()
        contentView.addSubview(subtitleLabel)
        
        dateAndLinkLabel = {
            let label = UILabel()
            label.text = "2021. 11. 24 * www.beansbin.oopy.io"
            
            return label
        }()
        contentView.addSubview(dateAndLinkLabel)
        
        alarmLabel = {
            let label = UILabel()
            label.text = "2021. 11. 17 오전 12:30 알림 예정"
            
            return label
        }()
        contentView.addSubview(alarmLabel)
        
        alarmImgView = {
            let imgView = UIImageView()
            imgView.image = UIImage()
            
            return imgView
        }()
        mainImgView.addSubview(alarmImgView)
        
        moreButton = {
            let button = UIButton()
            button.setTitle("...", for: .normal)
            return button
        }()
        contentView.addSubview(moreButton)
        
        isReadImgView = {
            let imgView = UIImageView()
            imgView.image = UIImage()
            
            return imgView
        }()
        contentView.addSubview(isReadImgView)
        
    }
    
    func setAutoLayouts() {
        mainImgView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView).offset(12)
            make.leading.equalTo(contentView).offset(16)
            make.trailing.equalTo(contentView).offset(19)
            make.height.equalTo(108)
        }
        
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(mainImgView).offset(12)
            make.top.equalTo(contentView).offset(12)
            make.trailing.equalTo(moreButton).offset(17)
        }
        
        subtitleLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(mainImgView).offset(12)
            make.top.equalTo(titleLabel).offset(6)
        }
        
        dateAndLinkLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(mainImgView).offset(12)
            make.top.equalTo(subtitleLabel).offset(15)
        }
        
        alarmLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(mainImgView).offset(12)
            make.top.equalTo(dateAndLinkLabel).offset(8)
        }
        
        alarmImgView.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(mainImgView).offset(0)
            make.top.equalTo(mainImgView).offset(0)
            make.width.equalTo(28)
            make.height.equalTo(28)
        }
        
        moreButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView).offset(15)
            make.trailing.equalTo(contentView).offset(-16)
            make.width.equalTo(16)
            make.height.equalTo(10)
        }
        
        isReadImgView.snp.makeConstraints { (make) -> Void in
            make.trailing.equalTo(contentView).offset(-14)
            make.bottom.equalTo(mainImgView).offset(-9)
            make.width.equalTo(31)
            make.height.equalTo(42)
        }
    }
}
