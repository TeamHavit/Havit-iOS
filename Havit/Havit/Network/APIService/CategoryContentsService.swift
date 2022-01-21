//
//  CategoryContentsService.swift
//  Havit
//
//  Created by 박예빈 on 2022/01/20.
//

import Foundation

struct CategoryContentsService: CategoryContentsSeriviceable {
    
    private let apiService: Requestable
    private let environment: APIEnvironment

    init(apiService: Requestable, environment: APIEnvironment) {
        self.apiService = apiService
        self.environment = environment
    }
    
    func getAllContents(option: String, filter: String) async throws -> [Content]? {
        let request = CategoryContentsEndPoint
            .getAllContents(option: option, filter: filter)
            .createRequest(environment: environment)
        return try await self.apiService.request(request)
    }
    
    func getCategoryContents(categoryID: String, option: String, filter: String) async throws -> [Content]? {
        let request = CategoryContentsEndPoint
            .getCategoryContents(categoryID: categoryID, option: option, filter: filter)
            .createRequest(environment: environment)
        return try await self.apiService.request(request)
    }
    
    func deleteContents(contentID: String) async throws -> Bool? {
        let request = CategoryContentsEndPoint
            .deleteContents(contentID: contentID)
            .createRequest(environment: environment)
        return try await self.apiService.request(request)
    }
}
