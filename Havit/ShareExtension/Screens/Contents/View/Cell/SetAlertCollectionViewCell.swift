//
//  SetAlertCollectionViewCell.swift
//  ShareExtension
//
//  Created by Noah on 2022/01/20.
//

import UIKit

import SnapKit

final class SetAlertCollectionViewCell: BaseCollectionViewCell {

    // MARK: - property
    
    private let alertTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .font(.pretendardSemibold, ofSize: 16)
        return label
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
        backgroundColor = .purpleCategory
        alertTimeLabel.textColor = .gray003
    }

    // MARK: - func
    
    override func render() {
        addSubViews([alertTimeLabel])

        alertTimeLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    override func configUI() {
        backgroundColor = .purpleCategory
        alertTimeLabel.textColor = .gray003
        layer.cornerRadius = 6
    }

    func update(alertTime: String) {
        alertTimeLabel.text = alertTime
    }
    
    func didSelect() {
        backgroundColor = .purple002
        alertTimeLabel.textColor = .havitGray
    }
    
    func didUnSelect() {
        backgroundColor = .purpleCategory
        alertTimeLabel.textColor = .gray003
        
    }
}
