//
//  CategoryFilterCollectionViewCell.swift
//  Havit
//
//  Created by 박예빈 on 2022/01/12.
//

import UIKit

final class CategoryFilterCollectionViewCell: UICollectionViewCell {
    static var cellID = "CategoryFilterCollectionViewCell"
    
    var filterNameLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setCell()
        setUpLabel()
    }
    
    func setCell() {
        filterNameLabel = UILabel()
        contentView.addSubview(filterNameLabel)
        filterNameLabel.translatesAutoresizingMaskIntoConstraints = false
        filterNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        filterNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        filterNameLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        filterNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    func setUpLabel() {
        // filterNameLabel.font = UIFont.systemFont(ofSize: 32)
        filterNameLabel.textAlignment = .center
    }
}
