//
//  SortBottomSheetTableViewCell.swift
//  Havit
//
//  Created by 박예빈 on 2022/01/14.
//

import UIKit

import SnapKit

class SortPanModalTableViewCell: BaseTableViewCell {
    var contentsSortType: ContentsSortType?
    
    var cellLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(.pretendardMedium, ofSize: 16)
        label.textColor = .gray004
        return label
    }()
    
    var borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray000
        return view
    }()
    
    override func render() {
        contentView.addSubViews([cellLabel, borderView])
        
        cellLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.leading.equalTo(contentView).offset(31)
        }
        
        borderView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(contentView)
            $0.height.equalTo(1)
        }
    }
}
