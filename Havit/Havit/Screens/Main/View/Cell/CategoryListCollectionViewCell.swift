//
//  CategoryListCollectionViewCell.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/16.
//

import UIKit

final class CategoryListCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        backgroundColor = .red
    }
    
}
