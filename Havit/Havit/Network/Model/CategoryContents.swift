//
//  CategoryContents.swift
//  Havit
//
//  Created by 박예빈 on 2022/01/20.
//
import Foundation

struct CategoryContents: Codable {
    let id: Int?
    let title: String?
    let orderIndex, imageID: Int?
    let imageURL: String?
    let contentNumber: Int?

    enum CodingKeys: String, CodingKey {
        case id, title, orderIndex
        case imageID = "imageId"
        case imageURL = "imageUrl"
        case contentNumber
    }
}
