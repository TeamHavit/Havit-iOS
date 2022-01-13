//
//  SearchBarView.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/14.
//

import UIKit

import SnapKit

final class SearchBarView: UIView {
    
    // MARK: - property
    
    private let searchIconImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .blue
        return image
    }()
    private let searchLabel: UILabel = {
        let label = UILabel()
        label.text = "원하는 콘텐츠 검색"
        label.font = .font(.pretendardMedium, ofSize: 14)
        label.textColor = .gray002
        return label
    }()
    private let bottomBar: UIView = {
        let bar = UIView()
        bar.backgroundColor = .gray001
        return bar
    }()

    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - func
    
    private func render() {
        addSubViews([searchIconImageView, searchLabel, bottomBar])
        
        searchIconImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(3)
            $0.width.equalTo(19)
            $0.height.equalTo(17)
        }
        
        searchLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(1)
            $0.leading.equalTo(searchIconImageView.snp.trailing).offset(8)
        }
        
        bottomBar.snp.makeConstraints {
            $0.top.equalTo(searchIconImageView.snp.bottom).offset(7)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(2)
        }
    }
}
