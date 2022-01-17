//
//  EmptyCategoryView.swift
//  Havit
//
//  Created by 김수연 on 2022/01/15.
//

import UIKit

import SnapKit

final class EmptyCategoryView: UIView {
    // MARK: - property

    private let categoryTipImageView: UIImageView = {
        let image = UIImageView()
        image.image = ImageLiteral.imgCategoryTip
        return image
    }()

    private let categoryTipLabel: UILabel = {
        let label = UILabel()
        label.text = "카테고리로 콘텐츠를 정리해보세요."
        label.font = .font(.pretendardReular, ofSize: 14)
        label.textColor = .white
        return label
    }()

    private let emptyImageView: UIImageView = {
        let image = UIImageView()
        image.image = ImageLiteral.imgGraphicNocategory
        return image
    }()

    private let noticeLabel: UILabel = {
        let label = UILabel()
        label.text = "아직 카테고리가 없습니다"
        label.font = .font(.pretendardBold, ofSize: 16)
        label.textColor = .black
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "HAVIT에 콘텐츠를 쉽게 저장할 수 있습니다.\n카테고리를 생성하려면 아래를 누르세요."
        label.textColor = .gray003
        label.font = .font(.pretendardReular, ofSize: 13)
        label.numberOfLines = 2
        label.addLabelSpacing(kernValue: -0.13, lineSpacing: 3.0)
        label.textAlignment = .center
        return label
    }()

    // MARK: - init

    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - func

    private func render() {
        addSubViews([categoryTipImageView, emptyImageView, noticeLabel, descriptionLabel])
        categoryTipImageView.addSubview(categoryTipLabel)

        categoryTipImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(145)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(49)
        }

        categoryTipLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.centerX.equalToSuperview()
        }

        emptyImageView.snp.makeConstraints {
            $0.top.equalTo(categoryTipImageView.snp.bottom).offset(45)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(203)
            $0.height.equalTo(246)
        }

        noticeLabel.snp.makeConstraints {
            $0.top.equalTo(emptyImageView.snp.bottom).offset(22)
            $0.centerX.equalTo(emptyImageView.snp.centerX)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(noticeLabel.snp.bottom).offset(12)
            $0.centerX.equalTo(emptyImageView.snp.centerX)
        }
    }
}
