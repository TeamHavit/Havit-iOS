//
//  CategoryIconCollectionViewCell.swift
//  Havit
//
//  Created by 김수연 on 2022/01/17.
//

import UIKit

import SnapKit

class CategoryIconCollectionViewCell: BaseCollectionViewCell {

    // MARK: - property

    private let iconBackgroundView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 62, height: 62))
        view.backgroundColor = .gray000
        view.layer.cornerRadius = 31
        return view
    }()

    private let iconImageView: UIImageView = {
        let image = UIImageView()
        image.image = ImageLiteral.iconCategory
        image.alpha = 0.7
        return image
    }()

    // MARK: - init

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - life cycle

    override var isSelected: Bool {
        didSet {
            iconImageView.alpha = self.isSelected ? 1 : 0.7
            iconBackgroundView.layer.borderWidth = self.isSelected ? 1.5 : 0
            iconBackgroundView.layer.borderColor = self.isSelected ? UIColor.havitPurple.cgColor : UIColor.clear.cgColor
        }
    }

    override func render() {
        self.addSubViews([iconBackgroundView, iconImageView])

        iconBackgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        iconImageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
            $0.width.height.equalTo(42)
        }
    }

    // MARK: - func

    func update(data: CategoryIconList) {
        iconImageView.image = data.categoryIcon
    }
}
