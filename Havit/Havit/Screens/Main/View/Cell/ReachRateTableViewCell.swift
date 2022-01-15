//
//  ReachRateTableViewCell.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/15.
//

import UIKit

final class ReachRateTableViewCell: BaseTableViewCell {
    
    // MARK: - property
    
    private let rateContentView = RateContentView()

    // MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func render() {
        addSubViews([rateContentView])
        
        rateContentView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(2)
            $0.width.equalTo(109)
        }
    }
}
