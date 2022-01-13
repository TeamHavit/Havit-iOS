//
//  CategoryCollectionViewCell.swift
//  Havit
//
//  Created by 김수연 on 2022/01/13.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    // MARK: - property
    private let categoryImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "category_icon")
        return image
    }()

    private let categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .font(.pretendardMedium, ofSize: 14)
        return label
    }()

    private let arrowImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "go_gray2")
        return image
    }()

    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayouts()
        setBackground()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - func
    private func setBackground() {
        self.backgroundColor = .purpleCategory
        layer.cornerRadius = 6
    }

    private func setLayouts() {
        setViewHierarchies()
        setConstraints()
    }

    private func setViewHierarchies() {
        self.addSubViews([categoryImageView, categoryTitleLabel, arrowImageView])
    }

    private func setConstraints() {
        categoryImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(7)
            $0.trailing.equalTo(categoryTitleLabel.snp.leading).offset(-7)
        }

        categoryTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.leading.equalTo(categoryImageView.snp.trailing).offset(7)
            $0.bottom.equalToSuperview().inset(19)
        }

        arrowImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(13)
            $0.trailing.equalToSuperview().inset(11)
            $0.bottom.equalToSuperview().inset(15)
            $0.width.height.equalTo(28)
        }
    }

}
