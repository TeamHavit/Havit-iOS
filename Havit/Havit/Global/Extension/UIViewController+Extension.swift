//
//  UIViewController+Extension.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/06.
//

import UIKit

extension UIViewController {
    func setupStatusBar(_ color: UIColor) {
        let statusbarView = UIView()
        statusbarView.backgroundColor = color
        statusbarView.frame = UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? .zero
        view.addSubview(statusbarView)
    }
}
