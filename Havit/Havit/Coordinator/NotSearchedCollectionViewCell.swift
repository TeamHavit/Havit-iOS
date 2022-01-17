//
//  NotSearchedCollectionViewCell.swift
//  Havit
//
//  Created by 박예빈 on 2022/01/17.
//

import UIKit

class NotSearchedCollectionViewCell: BaseCollectionViewCell {
    let label: UILabel = {
        let label = UILabel()
        label.text = "검색 결과가 없습니다."
        return label
    }()
    
    let imageView = UIImageView()
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    override func render() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.bottom.equalTo(contentView).offset(10)
            $0.leading.trailing.equalTo(contentView).offset(110)
        }
        
        contentView.addSubview(label)
        label.snp.makeConstraints {
            $0.bottom.equalTo(imageView).offset(30)
        }
    }
}
