//
//  Category.swift
//  Havit
//
//  Created by 김수연 on 2022/01/18.
//

import Foundation

struct Category: Decodable {
    let id: Int?
    var title: String?
    let orderIndex: Int?
    var imageId: Int?
    let imageUrl: String?
}
