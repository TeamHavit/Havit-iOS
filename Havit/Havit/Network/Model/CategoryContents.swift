//
//  CategoryContents.swift
//  Havit
//
//  Created by 박예빈 on 2022/01/20.
//
import Foundation

struct CategoryContents: Decodable {
    let id: Int?
    let title: String?
    let image: String?
    let datumDescription, url: String?
    let isSeen, isNotified: Bool?
    let notificationTime, createdAt, seenAt: String?

    enum CodingKeys: String, CodingKey {
        case id, title, image
        case datumDescription = "description"
        case url, isSeen, isNotified, notificationTime, createdAt, seenAt
    }
}
