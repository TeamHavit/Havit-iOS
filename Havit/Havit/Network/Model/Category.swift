//
//  Category.swift
//  Havit
//
//  Created by 김수연 on 2022/01/18.
//

import Foundation

struct Category: Decodable {
    let id: Int?
    let title: String?
    let orderIndex: Int?
    let imageUrl: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case orderIndex
        case imageUrl = "url"
    }
}
