//
//  MainUnwatchedEmptyView.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/19.
//

import UIKit

import SnapKit

final class MainUnwatchedEmptyView: UIView {
    
    // MARK: - property
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .font(.pretendardMedium, ofSize: 14)
        label.textColor = .gray002
        label.text = """
        최근에 저장한 콘텐츠가 없습니다.
        새로운 콘텐츠를 저장해 보세요!
        """
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
            $0.top.equalTo(noContentImageView.snp.bottom).offset(78)
            $0.width.equalTo(233)
            $0.height.equalTo(48)
        }
    }
    
    private func configUI() {
        backgroundColor = .whiteGray
        layer.cornerRadius = 6
    }
}
