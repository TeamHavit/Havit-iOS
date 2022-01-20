//
//  Content.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/20.
//

import Foundation

struct Content: Codable {
    let id: Int?
    let title: String?
    let contentDescription: String?
    let image: String?
    let url: String?
    let isSeen: Bool?
    let isNotified: Bool?
    let notificationTime: String?
    let createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id, title
        case contentDescription = "description"
        case image, url, isSeen, isNotified, notificationTime, createdAt
    }
}
