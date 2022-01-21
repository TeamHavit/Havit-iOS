//
//  SaveTargetContent.swift
//  Havit
//
//  Created by Noah on 2022/01/21.
//

import Foundation

struct SaveTargetContent: Codable {
    let ogTitle, ogDescription, ogImage, ogURL: String?

    enum CodingKeys: String, CodingKey {
        case ogTitle, ogDescription, ogImage
        case ogURL = "ogUrl"
    }
}
