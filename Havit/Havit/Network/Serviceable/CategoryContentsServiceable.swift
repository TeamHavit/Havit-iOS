//
//  CategoryContentsServiceable.swift
//  Havit
//
//  Created by 박예빈 on 2022/01/20.
//

import Foundation

protocol CategoryContentsSeriviceable {
    func getAllContents() async throws -> [CategoryContents]?
    func getCategoryContents(categoryID: String, option: String, filter: String) async throws -> [CategoryContents]?
    func deleteContents(contentID: String) async throws -> Bool?
}
