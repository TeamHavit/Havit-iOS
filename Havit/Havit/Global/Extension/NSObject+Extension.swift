//
//  NSObject+Extension.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/10.
//

import Foundation

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}
