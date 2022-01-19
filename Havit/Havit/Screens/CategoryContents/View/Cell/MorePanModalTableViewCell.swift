//
//  MoreBottomSheetTableViewCell.swift
//  Havit
//
//  Created by 박예빈 on 2022/01/15.
//

import UIKit

class MorePanModalTableViewCell: BaseTableViewCell {

    // MARK: - Properties
    var cellImageView: UIImageView = UIImageView()
    var label: UILabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func render() {
        contentView.addSubview(cellImageView)
        contentView.addSubview(label)
        
        cellImageView.snp.makeConstraints {
            $0.top.bottom.equalTo(contentView).inset(10)
            $0.leading.equalTo(contentView).inset(16)
        }
        
        label.snp.makeConstraints {
            $0.leading.equalTo(contentView).offset(7)
            $0.top.bottom.equalTo(contentView).inset(14)
        }
    }

}
