//
//  UIButton+Extension.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/06.
//

import UIKit

extension UIButton {
    func drawUnderline(to text: String, withStyle style: NSUnderlineStyle) {
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: style.rawValue]
        let underlineAttributedString = NSAttributedString(string: text, attributes: underlineAttribute)
        self.titleLabel?.attributedText = underlineAttributedString
    }
}
