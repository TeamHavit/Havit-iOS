//
//  CreateContent.swift
//  Havit
//
//  Created by Noah on 2022/01/22.
//

import Foundation

struct CreateContent: Encodable {
    let title: String
    let description: String
    let image: String
    let url: String
    let isNotified: Bool
    let notificationTime: String
    let categoryIds: [Int]
}
