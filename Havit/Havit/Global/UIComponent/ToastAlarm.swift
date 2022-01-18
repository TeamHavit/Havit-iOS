//
//  ToastAlarm.swift
//  Havit
//
//  Created by 박예빈 on 2022/01/14.
//

import UIKit

final class ToastAlarm {
    static func showToast(controller: UIViewController, message: String) {
        let font: UIFont = UIFont.systemFont(ofSize: 12.0)
        let toastLabel = UILabel(frame: CGRect(x: controller.view.frame.size.width/2 - 75,
                                               y: controller.view.frame.size.height - 100,
                                               width: 179,
                                               height: 40))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        toastLabel.textColor = UIColor.havitGray
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 15
        toastLabel.clipsToBounds = true
        controller.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 1.0,
                       delay: 0.5,
                       options: .curveEaseOut,
                       animations: { toastLabel.alpha = 0.0 },
                       completion: {(_) in toastLabel.removeFromSuperview()
        })
    }
}
