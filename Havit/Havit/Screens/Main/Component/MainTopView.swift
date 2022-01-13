//
//  MainTopView.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/13.
//

import UIKit

import SnapKit

final class MainTopView: UIView {
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    let alarmButton: UIButton = {
        let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 28, height: 28)))
        button.backgroundColor = .blue
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render() {
        adds([logoImageView, alarmButton])
        
        logoImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(17)
            $0.bottom.equalToSuperview().inset(13)
            $0.width.equalTo(68)
            $0.height.equalTo(12)
        }
        
        alarmButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(15)
            $0.bottom.equalToSuperview().inset(5)
        }
    }
}
