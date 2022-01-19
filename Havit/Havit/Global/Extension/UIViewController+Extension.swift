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

extension UIViewController {
    func makeAlert(title: String,
                   message: String,
                   okAction: ((UIAlertAction) -> Void)? = nil,
                   completion : (() -> Void)? = nil) {
        let alertViewController = UIAlertController(title: title,
                                                    message: message,
                                                    preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: okAction)
        alertViewController.addAction(okAction)
        self.present(alertViewController, animated: true, completion: completion)
    }

    func makeRequestAlert(title: String,
                         message: String,
                         okAction: ((UIAlertAction) -> Void)?,
                         cancelAction: ((UIAlertAction) -> Void)? = nil,
                         completion : (() -> Void)? = nil) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()

        let alertViewController = UIAlertController(title: title, message: message,
                                                    preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "취소", style: .destructive, handler: cancelAction)
        alertViewController.addAction(cancelAction)
        
        let okAction = UIAlertAction(title: "확인", style: .default, handler: okAction)
        alertViewController.addAction(okAction)

        self.present(alertViewController, animated: true, completion: completion)
    }
}
