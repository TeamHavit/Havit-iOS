//
//  ShareService.swift
//  Havit
//
//  Created by Noah on 2022/01/21.
//

import Foundation

struct ShareService: ShareServiceable {

    private let apiService: Requestable
    private let environment: APIEnvironment

    init(apiService: Requestable, environment: APIEnvironment) {
        self.apiService = apiService
        self.environment = environment
    }
    
    func getTargetContents(targetUrl: String) async throws -> SaveTargetContent? {
        let request = ShareEndPoint
            .getTargetContents(targetUrl: targetUrl)
            .createRequest(environment: environment)
        return try await self.apiService.request(request)
    }
}
