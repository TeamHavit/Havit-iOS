//
//  CategryContentsEndPoint.swift
//  Havit
//
//  Created by 박예빈 on 2022/01/20.
//

import Foundation

enum CategoryContentsEndPoint {
    case getCategoryContents(categoryID: String, option: String, filter: String)
    
    var requestTimeOut: Float {
        return 20
    }
    
    var httpMethod: HttpMethod {
        switch self {
        case .getCategoryContents:
            return .GET
        }
    }
    
    var requestBody: Data? {
        switch self {
        case .getCategoryContents:
            return nil
        }
    }
    
    func getURL(from environment: APIEnvironment) -> String {
        let baseUrl = environment.baseUrl
        switch self {
        case .getCategoryContents(let categoryID, let option, let filter):
            print("\(baseUrl)/category/\(categoryID)?option=\(option)&filter=\(filter)")
            return "\(baseUrl)/category/\(categoryID)?option=\(option)&filter=\(filter)"
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
