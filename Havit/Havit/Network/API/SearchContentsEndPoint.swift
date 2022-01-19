//
//  SearchContentsEndPoint.swift
//  Havit
//
//  Created by 박예빈 on 2022/01/19.
//

import Foundation

enum SearchContentsEndPoint {
    case getResult
    
    var requestTimeOut: Float {
        return 20
    }

    var httpMethod: HttpMethod {
        return .GET
    }

    var requestBody: Data? {
        return nil
    }

    func getURL(from environment: APIEnvironment) -> String {
        let baseUrl = environment.baseUrl
        return "\(baseUrl)/content/search/?keyword=\("임시 키워드")"
    }

    func createRequest(environment: APIEnvironment) -> NetworkRequest {
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json"
        headers["x-auth-token"] = environment.token
        return NetworkRequest(url: getURL(from: environment),
                              headers: headers,
                              reqBody: requestBody,
                              reqTimeout: requestTimeOut,
                              httpMethod: httpMethod)
    }
}
