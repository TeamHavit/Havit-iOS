//
//  MoreBottomSheetTableViewCell.swift
//  Havit
//
//  Created by 박예빈 on 2022/01/15.
//

import UIKit

import SnapKit

class MorePanModalTableViewCell: BaseTableViewCell {

    // MARK: - Property
    var cellImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    var borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray000
        return view
    }()
    
    var cellLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(.pretendardReular, ofSize: 16)
        label.textColor = .primaryBlack
        return label
    }()
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func render() {
        contentView.addSubViews([cellImageView, cellLabel, borderView])
        
        cellImageView.snp.makeConstraints {
            $0.top.bottom.equalTo(contentView).inset(10)
            $0.leading.equalTo(contentView).inset(16)
            $0.centerY.equalTo(contentView)
        }
        
        cellLabel.snp.makeConstraints {
            $0.leading.equalTo(cellImageView.snp.trailing).offset(7)
            $0.centerY.equalTo(contentView)
        }
        
        borderView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(contentView)
            $0.height.equalTo(1)
        }
    }

}
