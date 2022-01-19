//
//  LogoTableViewCell.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/18.
//

import UIKit

import SnapKit

final class LogoTableViewCell: BaseTableViewCell {
    
    // MARK: - property
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiteral.imgLogoBox
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    private let logoTitleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiteral.imgTextLogoGray
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    override func render() {
        contentView.addSubViews([logoImageView, logoTitleImageView])
        
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(28)
            $0.trailing.equalTo(self.snp.centerX).offset(-20)
            $0.bottom.equalToSuperview().inset(46)
            $0.height.width.equalTo(48).priority(.high)
        }
        
        logoTitleImageView.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.top).offset(18)
            $0.leading.equalTo(logoImageView.snp.trailing).offset(12)
            $0.width.equalTo(68)
            $0.height.equalTo(12)
        }
    }
    
    override func configUI() {
        selectionStyle = .none
        backgroundColor = .whiteGray
    }
}
