//
//  UIColor+Extension.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/06.
//

import UIKit

extension UIColor {
    static var gray000: UIColor {
        return UIColor(hex: "#f3f3f3")
    }
    
    static var gray001: UIColor {
        return UIColor(hex: "#dddce1")
    }
    
    static var gray002: UIColor {
        return UIColor(hex: "#afafb7")
    }
    
    static var gray003: UIColor {
        return UIColor(hex: "#74757e")
    }
    
    static var gray004: UIColor {
        return UIColor(hex: "#424247")
    }
    
    static var gray005: UIColor {
        return UIColor(hex: "#212225")
    }
    
    static var whiteGray: UIColor {
        return UIColor(hex: "#f6f6f8")
    }
    
    static var purpleText: UIColor {
        return UIColor(hex: "#7c73d9")
    }
    
    static var purpleLight: UIColor {
        return UIColor(hex: "#d6d5ff")
    }
    
    static var purpleCategory: UIColor {
        return UIColor(hex: "#f7f6ff")
    }
    
    static var purple001: UIColor {
        return UIColor(hex: "#efedff")
    }
    
    static var purple002: UIColor {
        return UIColor(hex: "#c3c2ff")
    }
    
    static var caution: UIColor {
        return UIColor(hex: "#ff6969")
    }
    
    static var havitGray: UIColor {
        return UIColor(hex: "#272b30")
    }
    
    static var havitWhite: UIColor {
        return UIColor(hex: "#fafafa")
    }
    
    static var havitPurple: UIColor {
        return UIColor(hex: "#8578ff")
    }
    
    static var havitRed: UIColor {
        return UIColor(hex: "#ef4848")
    }
    
    static var havitGreen: UIColor {
        return UIColor(hex: "#5fec86")
    }
    
    static var primaryBlack: UIColor {
        return UIColor(hex: "272B30")
    }
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: alpha)
    }
}
