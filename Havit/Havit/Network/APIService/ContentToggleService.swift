//
//  ContentToggleService.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/20.
//

import Foundation

struct ContentToggleService: ContentToggleServiceable {
    
    private let apiService: Requestable
    private let environment: APIEnvironment
    
    init(apiService: Requestable, environment: APIEnvironment) {
        self.apiService = apiService
        self.environment = environment
    }

    func patchContentToggle(contentId: Int) async throws -> ContentToggle? {
        let request = ContentToggleEndPoint
            .patchToggle(contentId: contentId)
            .createRequest(environment: environment)
        return try await self.apiService.request(request)
    }
}
