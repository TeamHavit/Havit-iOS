//
//  GuidelineTableViewCell.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/17.
//

import UIKit

import SnapKit

final class GuidelineTableViewCell: BaseTableViewCell {
    
    // MARK: - property
    
    private let guideImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiteral.imgGuide
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "콘텐츠 저장을 위한 해빗 서비스 이용 방법"
        label.font = .font(.pretendardReular, ofSize: 14)
        label.applyFont(to: "해빗 서비스 이용 방법", with: .font(.pretendardBold, ofSize: 14))
        return label
    }()

    override func render() {
        contentView.addSubView(guideImageView)
        guideImageView.addSubView(titleLabel)
        
        guideImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    override func configUI() {
        selectionStyle = .none
    }
}
