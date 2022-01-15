//
//  ReachRateNotificationTableViewCell.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/14.
//

import UIKit

import SnapKit

final class ReachRateNotificationTableViewCell: BaseTableViewCell {
    
    private enum Size {
        static let notificationWidth: CGFloat = {
            let sideMargin: CGFloat = 16
            return UIScreen.main.bounds.size.width - sideMargin * 2
        }()
    }
    
    // MARK: - property
    
    private let notificationView: UIView = {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Size.notificationWidth, height: 44)))
        view.clipsToBounds = true
        view.layer.cornerRadius = 6
        return view
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
        addSubView(notificationView)
        
        notificationView.snp.makeConstraints {
            $0.height.equalTo(44).priority(.high)
            $0.top.equalToSuperview().inset(5)
            $0.bottom.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    override func configUI() {
        notificationView.setGradient(start: .havitPurple, end: UIColor(hex: "6A5BFF"))
    }
}

private extension UIView {
    func setGradient(start startColor: UIColor, end endColor: UIColor) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
}
