//
//  ContentToggleEndPoint.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/20.
//

import Foundation

enum ContentToggleEndPoint {
    case patchToggle(contentId: Int)
    
    var requestTimeOut: Float {
        return 20
    }
    
    var httpMethod: HttpMethod {
        switch self {
        case .patchToggle:
            return .PATCH
        }
    }
    
    var requestBody: Data? {
        switch self {
        case .patchToggle(let contentId):
            let parameters = ["contentId": contentId]
            return parameters.encode()
        }
    }
    
    func getURL(from environment: APIEnvironment) -> String {
        let baseUrl = environment.baseUrl
        switch self {
        case .patchToggle:
            return "\(baseUrl)/content/check"
        }
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
