//
//  MainSearchHeaderView.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/14.
//

import UIKit

import RxCocoa
import SnapKit

final class MainSearchHeaderView: UIView {
    
    var didTapSearchHeader: (() -> Void)?

    // MARK: - property
    
    private let searchBarView = SearchBarView()
    private let corneredView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 18
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bind()
        render()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - func
    
    private func render() {
        addSubViews([searchBarView, corneredView])
        
        searchBarView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(22)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        corneredView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(30)
        }
    }
    
    private func bind() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        searchBarView.rx.gestureRecognizers
            .onNext([tap])
    }
    
    func updateBackgroundColor(to color: UIColor) {
        backgroundColor = color
    }
    
    @objc
    private func handleTap(_ sender: UITapGestureRecognizer) {
        didTapSearchHeader?()
    }
}
