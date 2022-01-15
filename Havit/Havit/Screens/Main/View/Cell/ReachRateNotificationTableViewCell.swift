//
//  ReachRateNotificationTableViewCell.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/14.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class ReachRateNotificationTableViewCell: BaseTableViewCell {
    
    private enum Size {
        static let notificationWidth: CGFloat = {
            let sideMargin: CGFloat = 16
            return UIScreen.main.bounds.size.width - sideMargin * 2
        }()
    }
    
    var didTapCloseButton: (() -> Void)?
    
    // MARK: - property
    
    private let notificationView: UIView = {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Size.notificationWidth, height: 44)))
        view.clipsToBounds = true
        view.layer.cornerRadius = 6
        return view
    }()
    private let notificationLabel: UILabel = {
        let label = UILabel()
        label.font = .font(.pretendardReular, ofSize: 14)
        label.textColor = .white
        return label
    }()
    fileprivate let closeButton: UIButton = {
        let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 16, height: 16)))
        button.backgroundColor = .purple002
        return button
    }()

    // MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        bind()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func render() {
        sendSubviewToBack(contentView)
        addSubViews([notificationView, notificationLabel, closeButton])
        
        notificationView.snp.makeConstraints {
            $0.height.equalTo(44).priority(.high)
            $0.top.equalToSuperview().inset(5)
            $0.bottom.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        closeButton.snp.makeConstraints {
            $0.centerY.equalTo(notificationView)
            $0.trailing.equalToSuperview().inset(29)
        }
        
        notificationLabel.snp.makeConstraints {
            $0.centerY.equalTo(notificationView)
            $0.leading.equalToSuperview().inset(36)
            $0.trailing.equalTo(closeButton.snp.leading).offset(-5)
        }
    }
    
    override func configUI() {
        backgroundColor = .clear
        notificationView.setGradient(colors: [UIColor.havitPurple.cgColor,
                                              UIColor(hex: "6A5BFF").cgColor])
    }
    
    // MARK: - func
    
    func bind() {
        closeButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.didTapCloseButton?()
            })
            .disposed(by: disposeBag)
    }
    
    func updateNotification(to text: String) {
        notificationLabel.text = text
    }
}
