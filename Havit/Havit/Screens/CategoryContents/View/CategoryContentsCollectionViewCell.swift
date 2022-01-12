//
//  CategoryContentsCollectionViewCell.swift
//  Havit
//
//  Created by 박예빈 on 2022/01/12.
//

import UIKit

class CategoryContentsCollectionViewCell: UICollectionViewCell {
    static var cellID = "CategoryContentsCollectionViewCell"
    
    var noticeLabel: UILabel!
    var imgView: UIImageView!
    var addButton: UIButton!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setCell()
        setAutoLayouts()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setCell()
        setAutoLayouts()
    }
    
    func setCell() {
        noticeLabel = {
            let label = UILabel()
            label.text = "아직 저장된 콘텐츠가 없습니다."
            return noticeLabel
        }()
        contentView.addSubview(noticeLabel)
        
        imgView = {
            let imgView = UIImageView()
            imgView.image = UIImage()
            return imgView
        }()
        contentView.addSubview(imgView)
        
        addButton = {
            let button = UIButton()
            button.setTitle("콘텐츠 추가", for: .normal)
            return addButton
        }()
        contentView.addSubview(addButton)
    }
    
    func setAutoLayouts() {
        noticeLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(contentView)
        }
        
        imgView.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(contentView)
        }
        
        addButton.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(contentView)
        }
    }
    
}
