//
//  ReachRateTableViewCell.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/15.
//

import UIKit

final class ReachRateTableViewCell: BaseTableViewCell {
    
    // MARK: - property
    
    private let rateContentView = RateContentView()
    private let unwatchedButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        let button = UIButton()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 11, bottom: 6, trailing: 11)
        configuration.attributedTitle = AttributedString("봐야 하는 콘텐츠", attributes: AttributeContainer([.font: UIFont.font(.pretendardMedium, ofSize: 12),
                                .foregroundColor: UIColor.gray003]))
        button.configuration = configuration
        button.layer.cornerRadius = 4
        button.layer.borderColor = UIColor.purple002.cgColor
        button.layer.borderWidth = 1
        return button
    }()

    // MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func render() {
        addSubViews([rateContentView, unwatchedButton])
        
        rateContentView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(2)
            $0.height.equalTo(109).priority(.high)
        }
        
        unwatchedButton.snp.makeConstraints {
            $0.top.equalTo(rateContentView.snp.top).inset(14)
            $0.trailing.equalTo(rateContentView.snp.trailing).inset(15)
        }
    }
    
    override func configUI() {
        backgroundColor = .clear
    }
    
    // MARK: - func
    
    func updateData(name: String, watched: Int, total: Int) {
        rateContentView.updateName(to: name)
        rateContentView.updateRate(to: watched, with: total)
    }
}