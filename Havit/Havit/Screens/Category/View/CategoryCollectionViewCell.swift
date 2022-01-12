//
//  CategoryCollectionViewCell.swift
//  Havit
//
//  Created by 김수연 on 2022/01/13.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    // MARK: - Vars & Lets Part

    // MARK: - UI Component Part

    private let categoryImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "category_icon")
        return image
    }()

    private let categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Medium", size: 14)
        return label
    }()

    private let arrowImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "go_gray2")
        return image
    }()

    // MARK: - Life Cycle Part
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayouts()
        setBackground()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Custom Method Part
    private func setBackground() {
        contentView.layer.backgroundColor = UIColor(red: 0.969, green: 0.965, blue: 1, alpha: 1).cgColor
        layer.cornerRadius = 6
        contentView.layer.cornerRadius = 6
    }

    // MARK: - Custom Method Part
}

// MARK: - Extension Part
extension CategoryCollectionViewCell {
    private func setLayouts() {
        setViewHierarchies()
        setConstraints()
    }

    private func setViewHierarchies() {
        // 이거 여러개 추가하는 extension 어케 쓰죵
        contentView.addSubview(categoryImageView)
        contentView.addSubview(categoryTitleLabel)
        contentView.addSubview(arrowImageView)
    }

    private func setConstraints() {
        categoryImageView.snp.makeConstraints {
            // 이미지뷰 레이아웃 뭐 잡아줘야하는지 !
            $0.top.leading.bottom.equalToSuperview().inset(7)
        }

        categoryTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.leading.equalTo(categoryImageView.snp.trailing).offset(7)
        }

        arrowImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(13)
            $0.trailing.equalToSuperview().inset(11)
            $0.bottom.equalToSuperview().inset(15)
        }
    }
}

