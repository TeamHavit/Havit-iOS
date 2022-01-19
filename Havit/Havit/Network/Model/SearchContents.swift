//
//  SearchContents.swift
//  Havit
//
//  Created by 박예빈 on 2022/01/19.
//

import Foundation

// MARK: - CategoryContents
struct CategoryContents: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: [ContentsData]?
}

// MARK: - ContentsData
struct ContentsData: Codable {
    let id: Int
    let title, datumDescription: String
    let image, url: String
    let isSeen, isNotified: Bool
    let notificationTime, createdAt: String

    enum CodingKeys: String, CodingKey {
        case id, title
        case datumDescription = "description"
        case image, url, isSeen, isNotified, notificationTime, createdAt
    }
}
