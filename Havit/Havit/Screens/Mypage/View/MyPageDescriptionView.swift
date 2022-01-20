//
//  MyPageDescriptionView.swift
//  Havit
//
//  Created by 김수연 on 2022/01/20.
//

import UIKit

class MyPageDescriptionView: UIView {

    var iconImageView: UIImageView = {
        let image = UIImageView()
        image.image = ImageLiteral.iconMyPageCategory
        return image
    }()

    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "카테고리 수"
        label.font = .font(.pretendardReular, ofSize: 13)
        return label
    }()

    var countLabel: UILabel = {
        let label = UILabel()
        label.text = "20개"
        label.font = .font(.pretendardSemibold, ofSize: 15)
        return label
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
        addSubViews([iconImageView, titleLabel, countLabel])

        iconImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(21)
            $0.leading.equalToSuperview().inset(23)
            $0.width.height.equalTo(57)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(iconImageView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(15)
            $0.trailing.equalToSuperview().inset(12)
        }

        countLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(3)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.bottom.equalToSuperview().inset(16)
        }
    }

    private func configUI() {
        backgroundColor = .white
        layer.cornerRadius = 10
    }
}
