//
//  UIView+Extension.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/06.
//

import UIKit

extension UIView {
    @discardableResult
    func makeShadow(_ color: UIColor,
                    _ opacity: Float,
                    _ offset: CGSize,
                    _ radius: CGFloat) -> Self {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        return self
    }
    
    func addSubView<T: UIView>(_ subview: T, completionHandler closure: ((T) -> Void)? = nil) {
        addSubview(subview)
        closure?(subview)
    }
    
    func addSubViews<T: UIView>(_ subviews: [T], completionHandler closure: (([T]) -> Void)? = nil) {
        subviews.forEach { addSubview($0) }
        closure?(subviews)
    }
    
    // MARK: - CustomBTNavigationDropDownMenu
    struct Static {
        static var key = "key"
    }
    var viewIdentifier: String? {
        get {
            return objc_getAssociatedObject( self, &Static.key ) as? String
        }
        set {
            objc_setAssociatedObject(self, &Static.key, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}
