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
        imageView.backgroundColor = .havitGreen
        return imageView
    }()
    
    override func render() {
        contentView.addSubView(logoImageView)
        
        logoImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(122)
        }
    }
}
