//
//  CategoryService.swift
//  Havit
//
//  Created by 김수연 on 2022/01/18.
//

import Foundation

struct CategoryService: CategorySeriviceable {

    private let apiService: Requestable
    private let environment: APIEnvironment

    init(apiService: Requestable, environment: APIEnvironment) {
        self.apiService = apiService
        self.environment = environment
    }

    func getCategory() async throws -> [Category]? {
        let request = CategoryEndPoint
            .getCategory
            .createRequest(environment: environment)
        return try await self.apiService.request(request)
    }

    func editCategory(categoryId: Int, title: String, imageId: Int) async throws -> String? {
        let request = CategoryEndPoint.editCategory(categoryId: categoryId, title: title, imageId: imageId).createRequest(environment: environment)
        return try await self.apiService.request(request)
    }
    
    func changeCategoryOrder(categoryIndexArray: [Int]) async throws -> [Int]? {
        let request = CategoryEndPoint.changeCategoryOrder(categoryIndexArray: categoryIndexArray).createRequest(environment: environment)
        return try await self.apiService.request(request)
    }

    func deleteCategory(categoryId: Int) async throws -> Int? {
        let request = CategoryEndPoint.deleteCategory(categoryId: categoryId).createRequest(environment: environment)
        return try await self.apiService.request(request)
    }
}
