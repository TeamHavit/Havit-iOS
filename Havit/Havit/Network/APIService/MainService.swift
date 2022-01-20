//
//  MainService.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/20.
//

import Foundation

struct MainService: MainServiceable {
    
    private let apiService: Requestable
    private let environment: APIEnvironment

    init(apiService: Requestable, environment: APIEnvironment) {
        self.apiService = apiService
        self.environment = environment
    }

    func getCategory() async throws -> [Category]? {
        let request = MainEndPoint
            .getCategory
            .createRequest(environment: environment)
        return try await self.apiService.request(request)
    }

    func getRecentContent() async throws -> [Content]? {
        let request = MainEndPoint
            .getRecentContent
            .createRequest(environment: environment)
        return try await self.apiService.request(request)
    }
    
    func getRecommendSite() async throws -> [Site]? {
        let request = MainEndPoint
            .getRecommend
            .createRequest(environment: environment)
        return try await self.apiService.request(request)
    }
}
