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
        let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWRGaXJlYmFzZSI6IiIsImlhdCI6MTY0MjEzOTgwMCwiZXhwIjoxNjQ0NzMxODAwLCJpc3MiOiJoYXZpdCJ9.-VsZ4c5mU96GRwGSLjf-hSiU8HD-LVK8V3a5UszUAWk"
        let request = CategoryEndPoint
            .getCategory
            .createRequest(token: token,
                           environment: environment)
        return try await self.apiService.request(request)
    }
}
