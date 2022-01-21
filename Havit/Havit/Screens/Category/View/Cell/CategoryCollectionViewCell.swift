//
//  CategoryCollectionViewCell.swift
//  Havit
//
//  Created by 김수연 on 2022/01/13.
//

import UIKit

import Kingfisher
import RxCocoa
import RxSwift
import SnapKit

enum CategoryCollectionViewCellType {
    case category
    case manage
}

class CategoryCollectionViewCell: BaseCollectionViewCell {

    // MARK: - property

    var presentEditCategoryClosure: (() -> Void)? 

    var categoryImageView: UIImageView = {
        let image = UIImageView()
        image.image = ImageLiteral.imgCategoryNone
        // image.contentMode = .scaleToFill
        return image
    }()

    var categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .font(.pretendardMedium, ofSize: 14)
        return label
    }()

    private lazy var arrowImageView: UIImageView = {
        let image = UIImageView()
        image.image = ImageLiteral.iconGoGray
        image.contentMode = .scaleToFill
        return image
    }()

    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiteral.iconCategoryEdit, for: .normal)
        return button
    }()

    // MARK: - init

    override init(frame: CGRect) {
        super.init(frame: frame)
        bind()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        categoryImageView.image = nil
        categoryTitleLabel.text = ""
        backgroundColor = .purpleCategory
    }

    // MARK: - life cycle

    override func render() {
        self.addSubViews([categoryImageView, categoryTitleLabel])

        categoryImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(10)
            $0.width.height.equalTo(36)
        }

        categoryTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.leading.equalTo(categoryImageView.snp.trailing).offset(7)
            $0.bottom.equalToSuperview().inset(19)
        }
    }

    override func configUI() {
        self.backgroundColor = .purpleCategory
        layer.cornerRadius = 6
    }

    // MARK: - func

    func configure(type: CategoryCollectionViewCellType) {
        switch type {
        case .category:
            self.addSubView(arrowImageView)

            arrowImageView.snp.makeConstraints {
                $0.top.equalToSuperview().inset(13)
                $0.trailing.equalToSuperview().inset(11)
                $0.bottom.equalToSuperview().inset(15)
                $0.width.height.equalTo(28)
            }
        case .manage:
            self.addSubView(editButton)

            editButton.snp.makeConstraints {
                $0.top.equalToSuperview().inset(14)
                $0.trailing.equalToSuperview().inset(12)
                $0.bottom.equalToSuperview().inset(14)
            }
        }
    }

    // MARK: - func

    func update(data: Category) {
        if let url = URL(string: data.imageUrl ?? "") {
            categoryImageView.kf.setImage(with: url)
        }
        categoryTitleLabel.text = data.title
    }

    private func bind() {
        editButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.presentEditCategoryClosure?()
            })
            .disposed(by: disposeBag)
    }
}
