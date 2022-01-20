//
//  CategoryPanModalTableViewCell.swift
//  Havit
//
//  Created by 박예빈 on 2022/01/19.
//

import UIKit

import SnapKit

class CategoryPanModalTableViewCell: BaseTableViewCell {
    var cellLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(.pretendardSemibold, ofSize: 14)
        label.textColor = .gray003
        return label
    }()
    
    var cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiteral.iconcheck
        return imageView
    }()
    
    var border: UIView = {
        let view = UIView()
        view.backgroundColor = .gray000
        return view
    }()
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func render() {
        contentView.addSubViews([cellLabel, border, cellImageView])
        
        cellLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.leading.equalTo(contentView).offset(31)
        }
        
        cellImageView.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.leading.equalTo(cellLabel.snp.trailing).offset(7)
            $0.width.height.equalTo(15)
        }
        
        border.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(contentView)
            $0.height.equalTo(1)
        }
    }
}
