//
//  ShareEndPoint.swift
//  Havit
//
//  Created by Noah on 2022/01/21.
//

import Foundation

enum ShareEndPoint {
    case getTargetContents(targetUrl: String)
    
    var requestTimeOut: Float {
        return 20
    }
    
    var httpMethod: HttpMethod {
        switch self {
        case .getTargetContents:
            return .GET
        }
    }
    
    var requestBody: Data? {
        switch self {
        case .getTargetContents:
            return nil
        }
    }
    
    func getURL(from environment: APIEnvironment) -> String {
        let baseUrl = environment.baseUrl
        switch self {
        case .getTargetContents(let targetUrl):
            return "\(baseUrl)/content/scrap?link=\(targetUrl)"
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
