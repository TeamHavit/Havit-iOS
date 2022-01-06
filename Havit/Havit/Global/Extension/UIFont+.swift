//
//  UIFont+.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/06.
//

import UIKit

struct FontName {
    static let dinProRegular = "DINPro-Regular"
}

extension UIFont {
    @objc class func regularDINProFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: FontName.dinProRegular, size: size)!
    }
}
