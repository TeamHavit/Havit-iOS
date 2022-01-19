//
//  MainRecentContentEmptyView.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/19.
//

import UIKit

import SnapKit

final class MainRecentContentEmptyView: UIView {
    
    // MARK: - property
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .font(.pretendardReular, ofSize: 13)
        label.textColor = .gray003
        label.text = "저장한 컨텐츠가 없습니다"
        return label
    }()
    private let contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiteral.iconChipGray
        return imageView
    }()

    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
        configUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - func
    
    private func render() {
        addSubViews([titleLabel, contentImageView])
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().inset(39)
        }
        
        contentImageView.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.trailing.equalTo(titleLabel.snp.leading).offset(9)
        }
    }
    
    private func configUI() {
        backgroundColor = .whiteGray
        layer.cornerRadius = 6
    }
}
