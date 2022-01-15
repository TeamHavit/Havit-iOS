//
//  Encodable+Extension.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/14.
//

import Foundation

extension Encodable {
    func encode() -> Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            return nil
        }
    }
}
