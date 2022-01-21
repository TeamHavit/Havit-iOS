//
//  ShareCategoryCollectionViewCell.swift
//  ShareExtension
//
//  Created by Noah on 2022/01/20.
//

import UIKit

import SnapKit

final class ShareCategoryCollectionViewCell: BaseCollectionViewCell {

    // MARK: - property
    
    private let categoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiteral.imgCategoryNone
        return imageView
    }()

    private let categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .font(.pretendardMedium, ofSize: 14)
        return label
    }()

    private lazy var checkIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiteral.iconcheck
        return imageView
    }()

    // MARK: - init

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        categoryImageView.image = nil
        categoryTitleLabel.text = ""
    }

    // MARK: - func
    
    override func render() {
        addSubViews([categoryImageView,
                     categoryTitleLabel,
                     checkIcon])

        categoryImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(7)
            $0.width.height.equalTo(36)
        }

        categoryTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(categoryImageView.snp.trailing).offset(7)
        }
        
        checkIcon.snp.makeConstraints {
            $0.centerY.equalTo(categoryImageView)
            $0.trailing.equalToSuperview().inset(19)
        }
    }

    override func configUI() {
        checkIcon.isHidden = true
        backgroundColor = .purpleCategory
        layer.cornerRadius = 6
    }

    func update(data: Category) {
        categoryImageView.image = ImageLiteral.iconCategory
        categoryTitleLabel.text = data.title
    }
    
    func didSelect() {
        backgroundColor = .purple002
        checkIcon.isHidden = false
    }
    
    func didUnSelect() {
        backgroundColor = .purpleCategory
        checkIcon.isHidden = true
    }
}
