//
//  MoreBottomSheetTableViewCell.swift
//  Havit
//
//  Created by 박예빈 on 2022/01/15.
//

import UIKit

class MorePanModalTableViewCell: BaseTableViewCell {

    // MARK: - Properties
    var cellImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    var border: UIView = {
        let view = UIView()
        view.backgroundColor = .gray000
        return view
    }()
    
    var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(.pretendardReular, ofSize: 16)
        label.textColor = .primaryBlack
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func render() {
        contentView.addSubViews([cellImageView, label, border])
        
        cellImageView.snp.makeConstraints {
            $0.top.bottom.equalTo(contentView).inset(10)
            $0.leading.equalTo(contentView).inset(16)
            $0.centerY.equalTo(contentView)
        }
        
        label.snp.makeConstraints {
            $0.leading.equalTo(cellImageView.snp.trailing).offset(7)
            $0.centerY.equalTo(contentView)
        }
        
        border.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(contentView)
            $0.height.equalTo(1)
        }
    }

}
