//
//  NotSearchedCollectionViewCell.swift
//  Havit
//
//  Created by 박예빈 on 2022/01/17.
//

import UIKit

import SnapKit

class NotSearchedCollectionViewCell: BaseCollectionViewCell {
    let noResultLabel: UILabel = {
        let label = UILabel()
        label.text = "검색 결과가 없습니다."
        label.font = UIFont.font(.pretendardMedium, ofSize: CGFloat(14))
        label.textColor = .gray002
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    override func render() {
        contentView.addSubViews([imageView, noResultLabel])
        
        imageView.snp.makeConstraints {
            $0.bottom.equalTo(contentView).inset(20)
            $0.centerX.equalTo(contentView)
        }
        
        noResultLabel.snp.makeConstraints {
            $0.bottom.equalTo(imageView.snp.top).inset(-40)
            $0.centerX.equalTo(contentView)
        }
    }
}
