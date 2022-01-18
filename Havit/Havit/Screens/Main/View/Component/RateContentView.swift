//
//  RateContentView.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/15.
//

import UIKit

import RxSwift
import SnapKit

final class RateContentView: UIView {
    
    // MARK: - property
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .font(.pretendardSemibold, ofSize: 19)
        label.textColor = .gray004
        return label
    }()
    private let fractionLabel: UILabel = {
        let label = UILabel()
        label.font = .font(.pretendardReular, ofSize: 10)
        label.textColor = .gray003
        return label
    }()
    private let progressLabel: UILabel = {
        let label = UILabel()
        label.font = .font(.pretendardBold, ofSize: 38)
        label.textColor = .havitPurple
        label.textAlignment = .right
        return label
    }()
    private let progressBar: UIProgressView = {
        let bar = UIProgressView()
        bar.tintColor = .gray000
        bar.progressTintColor = .havitPurple
        return bar
    }()

    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
        configUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - func
    
    private func render() {
        addSubViews([nameLabel, fractionLabel, progressBar, progressLabel])
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(17)
            $0.leading.equalToSuperview().inset(14)
            $0.trailing.equalToSuperview().inset(120)
        }
        
        fractionLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(22)
            $0.leading.equalTo(nameLabel)
        }
        
        progressBar.snp.makeConstraints {
            $0.top.equalTo(fractionLabel.snp.bottom).offset(5)
            $0.leading.equalTo(nameLabel)
            $0.height.equalTo(5)
        }
        
        progressLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(17)
            $0.bottom.equalToSuperview().inset(10)
            $0.leading.equalTo(progressBar.snp.trailing).offset(3)
            $0.width.equalTo(87).priority(.high)
        }
    }
    
    private func configUI() {
        backgroundColor = .white
        layer.cornerRadius = 6
        makeShadow(color: .gray002, opacity: 0.2, offset: CGSize(width: 0, height: 5), radius: 5)
    }
    
    private func animateProgressBar(rate: Float) {
        DispatchQueue.main.async { [weak self] in
            self?.progressBar.setProgress(rate, animated: false)
            UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
                self?.progressBar.layoutIfNeeded()
            })
        }
    }
    
    func updateName(to name: String) {
        nameLabel.text = "\(name)님의 도달률"
    }
    
    func updateRate(to watched: Int, with total: Int) {
        let rate: Double = Double(watched) / Double(total)
        
        fractionLabel.text = "\(watched) / \(total)"
        fractionLabel.applyFont(to: String(watched), with: .font(.pretendardExtraBold, ofSize: 16))
        progressLabel.text = "\(Int(rate * 100))%"
        progressLabel.applyFont(to: "%", with: .font(.pretendardLight, ofSize: 20))
        
        animateProgressBar(rate: Float(rate))
    }
}
