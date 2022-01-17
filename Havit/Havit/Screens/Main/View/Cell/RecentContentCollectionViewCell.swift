//
//  RecentContentCollectionViewCell.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/17.
//

import UIKit

final class RecentContentCollectionViewCell: BaseCollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .gray003
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
