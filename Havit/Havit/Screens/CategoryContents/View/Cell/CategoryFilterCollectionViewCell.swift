//
//  CategoryFilterCollectionViewCell.swift
//  Havit
//
//  Created by 박예빈 on 2022/01/12.
//

import UIKit

final class CategoryFilterCollectionViewCell: BaseCollectionViewCell {

    var filterNameLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.font(FontName.pretendardSemibold, ofSize: CGFloat(12))
        label.textColor = .gray003
        return label
    }()
    
    var filterImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "btnAlarmGray")
        return imageView
    }()
    
    static func fittingSize(availableHeight: CGFloat, name: String?) -> CGSize {
        let cell = CategoryFilterCollectionViewCell()
        cell.configure(name: name)
        
        let targetSize = CGSize(width: UIView.layoutFittingCompressedSize.width, height: availableHeight)
        return cell.contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .required)
    }
    
    func configure(name: String?) {
        filterNameLabel.text = name
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    override func render() {
        contentView.addSubview(filterNameLabel)
        filterNameLabel.snp.makeConstraints {
            $0.centerX.equalTo(contentView)
            $0.centerY.equalTo(contentView)
        }
        
        contentView.addSubview(filterImageView)
        filterImageView.snp.makeConstraints {
            $0.centerX.equalTo(contentView)
            $0.centerY.equalTo(contentView)
        }
    }
    
    override func configUI() {
        super.configUI()
        contentView.backgroundColor = .whiteGray
    }
}
