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
    
    @discardableResult
    func setGradient(_ colors: [CGColor],
                     _ locations: [NSNumber] = [0.0, 1.0],
                     _ startPoint: CGPoint = CGPoint(x: 0.0, y: 0.0),
                     _ endPoint: CGPoint = CGPoint(x: 1.0, y: 0.0)) -> Self {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = colors
        gradient.locations = locations
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.frame = self.bounds
        layer.addSublayer(gradient)
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
}
