//
//  CategoryListCollectionViewCell.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/16.
//

import UIKit

final class CategoryListCollectionViewCell: BaseCollectionViewCell {
    
    let titleLabel = UILabel()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .red
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
