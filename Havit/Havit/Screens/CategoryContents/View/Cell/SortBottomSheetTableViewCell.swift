//
//  SortBottomSheetTableViewCell.swift
//  Havit
//
//  Created by 박예빈 on 2022/01/14.
//

import UIKit

import SnapKit

class SortBottomSheetTableViewCell: BaseTableViewCell {
    var label: UILabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func render() {
        contentView.addSubview(label)
        
        label.snp.makeConstraints {
            $0.leading.equalTo(contentView).offset(31)
            $0.top.equalTo(contentView).offset(14)
            $0.bottom.equalTo(contentView).offset(15)
        }
    }

}
