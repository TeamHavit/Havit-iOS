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
        label.font = UIFont.font(FontName.pretendardMedium, ofSize: CGFloat(14))
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
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.bottom.equalTo(contentView).inset(20)
            $0.centerX.equalTo(contentView)
        }
        
        contentView.addSubview(label)
        label.snp.makeConstraints {
            $0.top.equalTo(imageView).inset(-70)
            $0.centerX.equalTo(contentView)
        }
    }
}
