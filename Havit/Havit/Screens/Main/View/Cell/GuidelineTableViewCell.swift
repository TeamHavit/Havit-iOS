//
//  GuidelineTableViewCell.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/17.
//

import UIKit

import SnapKit

final class GuidelineTableViewCell: BaseTableViewCell {

    // MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .red
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
