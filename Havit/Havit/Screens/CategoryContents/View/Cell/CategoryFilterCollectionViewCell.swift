//
//  CategoryFilterCollectionViewCell.swift
//  Havit
//
//  Created by 박예빈 on 2022/01/12.
//

import UIKit

final class CategoryFilterCollectionViewCell: BaseCollectionViewCell {
    static var cellID = "CategoryFilterCollectionViewCell"
    
    var filterNameLabel: UILabel = {
        return UILabel()
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configUI()
        setUpLabel()
    }
    
    override func configUI() {
        // 이 부분은 디자인 부분에서 다시 수정할 예정입니다!!
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
