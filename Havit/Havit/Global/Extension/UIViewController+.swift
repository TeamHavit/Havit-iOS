//
//  UIViewController+.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/06.
//

import UIKit

extension UIViewController {
    func setupStatusBar(_ color: UIColor) {
        if #available(iOS 13.0, *) {
            let margin = view.layoutMarginsGuide
            let statusbarView = UIView()
            statusbarView.backgroundColor = color
            statusbarView.frame = CGRect.zero
            view.addSubview(statusbarView)
            statusbarView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                statusbarView.topAnchor.constraint(equalTo: view.topAnchor),
                statusbarView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0),
                statusbarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                statusbarView.bottomAnchor.constraint(equalTo: margin.topAnchor)
            ])
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = color
        }
    }
}

