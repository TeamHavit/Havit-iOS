//
//  MainContentEmptyView.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/19.
//

import UIKit

import SnapKit

final class MainContentEmptyView: UIView {
    
    // MARK: - property
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .font(.pretendardMedium, ofSize: 14)
        label.textColor = .gray002
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    private let noContentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiteral.imgGraphicNocontents
        return imageView
    }()
    private let createContentButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .font(.pretendardMedium, ofSize: 15)
        button.setTitle("콘텐츠 추가", for: .normal)
        button.setTitleColor(.havitPurple, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.havitPurple.cgColor
        button.layer.cornerRadius = 24
        return button
    }()
    
    private var isCategoryContentView: Bool

    // MARK: - init
    
    init(guideText: String, isCategoryContentView: Bool = false) {
        self.isCategoryContentView = isCategoryContentView
        super.init(frame: .zero)
        titleLabel.text = guideText
        render()
        configUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - func
    
    private func render() {
        addSubViews([titleLabel, noContentImageView, createContentButton])
        
        noContentImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-30)
            $0.width.equalTo(203)
            $0.height.equalTo(246)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(noContentImageView.snp.top).offset(-39)
        }
        
        createContentButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(noContentImageView.snp.bottom).offset(isCategoryContentView ? 30 : 78)
            $0.width.equalTo(233)
            $0.height.equalTo(48)
        }
    }
    
    private func configUI() {
        backgroundColor = .whiteGray
        layer.cornerRadius = 6
    }
}
