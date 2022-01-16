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
    
    // Get ViewController in top present level
    var topPresentedViewController: UIViewController? {
        var target: UIViewController? = self
        while target?.presentedViewController != nil {
            target = target?.presentedViewController
        }
        return target
    }
    
    
    // MARK: - CustomBTNavigationDropDownMenu
    // Get top VisibleViewController from ViewController stack in same present level.
    // It should be visibleViewController if self is a UINavigationController instance
    // It should be selectedViewController if self is a UITabBarController instance
    var topVisibleViewController: UIViewController? {
        if let navigation = self as? UINavigationController {
            if let visibleViewController = navigation.visibleViewController {
                return visibleViewController.topVisibleViewController
            }
        }
        if let tab = self as? UITabBarController {
            if let selectedViewController = tab.selectedViewController {
                return selectedViewController.topVisibleViewController
            }
        }
        return self
    }
    
    // Combine both topPresentedViewController and topVisibleViewController methods, to get top visible viewcontroller in top present level
    var topMostViewController: UIViewController? {
        return self.topPresentedViewController?.topVisibleViewController
    }
}
