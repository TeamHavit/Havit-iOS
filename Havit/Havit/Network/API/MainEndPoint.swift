//
//  MainEndPoint.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/20.
//

import Foundation

enum MainEndPoint {
    case getCategory
    case getRecentContent
    case getRecommend
    case getUnseen
    case getReachRate
    
    var requestTimeOut: Float {
        return 20
    }
    
    var httpMethod: HttpMethod {
        switch self {
        case .getCategory:
            return .GET
        case .getRecentContent:
            return .GET
        case .getRecommend:
            return .GET
        case .getUnseen:
            return .GET
        case .getReachRate:
            return .GET
        }
    }
    
    var requestBody: Data? {
        switch self {
        case .getCategory:
            return nil
        case .getRecentContent:
            return nil
        case .getRecommend:
            return nil
        case .getUnseen:
            return nil
        case .getReachRate:
            return nil
        }
    }
    
    func getURL(from environment: APIEnvironment) -> String {
        let baseUrl = environment.baseUrl
        switch self {
        case .getCategory:
            return "\(baseUrl)/category"
        case .getRecentContent:
            return "\(baseUrl)/content/recent"
        case .getRecommend:
            return "\(baseUrl)/recommendation"
        case .getUnseen:
            return "\(baseUrl)/content/unseen"
        case .getReachRate:
            return "\(baseUrl)/user"
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
