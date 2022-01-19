//
//  MainCategoryEmptyView.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/19.
//

import UIKit

import SnapKit

final class MainCategoryEmptyView: UIView {
    
    // MARK: - property
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .font(.pretendardMedium, ofSize: 16)
        label.textColor = .primaryBlack
        label.text = "아직 카테고리가 없습니다"
        return label
    }()
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .font(.pretendardReular, ofSize: 13)
        label.textColor = .gray003
        label.text = """
        HAVIT에 콘텐츠를 쉽게 저장할 수 있습니다
        카테고리를 생성하려면 아래를 누르세요
        """
        label.textAlignment = .center
        return label
    }()
    private let noCategoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = ImageLiteral.imgGraphicNocategory
        return imageView
    }()
    let createCategoryButton: UIButton = {
        let container = AttributeContainer([.font: UIFont.font(.pretendardMedium, ofSize: 15),
                                            .foregroundColor: UIColor.white])
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = AttributedString("카테고리 생성", attributes: container)
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 14, leading: 0, bottom: 14, trailing: 0)
        let button = UIButton()
        button.configuration = configuration
        button.backgroundColor = .havitPurple
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
        addSubViews([titleLabel, subTitleLabel, noCategoryImageView, createCategoryButton])
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(43)
            $0.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(13)
            $0.centerX.equalToSuperview()
        }
        
        noCategoryImageView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(95)
            $0.height.equalTo(88)
        }
        
        createCategoryButton.snp.makeConstraints {
            $0.top.equalTo(noCategoryImageView.snp.bottom).offset(9)
            $0.leading.trailing.equalToSuperview().inset(53)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func configUI() {
        backgroundColor = .whiteGray
        layer.cornerRadius = 6
    }
}
