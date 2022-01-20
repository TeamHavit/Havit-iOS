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
    
    func getCategoryContents(option: String, filter: String) async throws -> [CategoryContents]? {
        let request = CategoryEndPoint
            .getCategory
            .createRequest(environment: environment)
        return try await self.apiService.request(request)
    }
}
