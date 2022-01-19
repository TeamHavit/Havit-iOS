//
//  SearchContentsService.swift
//  Havit
//
//  Created by 박예빈 on 2022/01/19.
//

import Foundation

struct SearchContentService: SearchContentsSeriviceable {

    private let apiService: Requestable
    private let environment: APIEnvironment

    init(apiService: Requestable, environment: APIEnvironment) {
        self.apiService = apiService
        self.environment = environment
    }

    func getSearchResult() async throws -> [SearchContents]? {
        let request = SearchContentsEndPoint
            .getResult
            .createRequest(environment: environment)
        return try await self.apiService.request(request)
    }
}
