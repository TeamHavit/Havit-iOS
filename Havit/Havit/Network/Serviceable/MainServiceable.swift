//
//  MainServiceable.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/20.
//

import Foundation

protocol MainServiceable {
    func getCategory() async throws -> [Category]?
    func getRecentContent() async throws -> [Content]?
    func getRecommendSite() async throws -> [Site]?
    func getUnseen() async throws -> [Content]?
}
