//
//  CategryContentsEndPoint.swift
//  Havit
//
//  Created by 박예빈 on 2022/01/20.
//

import Foundation

enum CategoryContentsEndPoint {
    case getAllContents(option: String, filter: String)
    case getCategoryContents(categoryID: String, option: String, filter: String)
    case deleteContents(contentID: String)
    
    var requestTimeOut: Float {
        return 20
    }
    
    var httpMethod: HttpMethod {
        switch self {
        case .getAllContents:
            return .GET
        case .getCategoryContents:
            return .GET
        case .deleteContents:
            return .DELETE
        }
    }
    
    var requestBody: Data? {
        switch self {
        case .getAllContents:
            return nil
        case .getCategoryContents:
            return nil
        case .deleteContents:
            return nil
        }
    }
    
    func getURL(from environment: APIEnvironment) -> String {
        let baseUrl = environment.baseUrl
        switch self {
        case .getAllContents(let option, let filter):
            print("\(baseUrl)/content?option=\(option)&filter=\(filter)")
            return "\(baseUrl)/content?option=\(option)&filter=\(filter)"
        case .getCategoryContents(let categoryID, let option, let filter):
            print("\(baseUrl)/content?option=\(option)&filter=\(filter)")
            return "\(baseUrl)/category/\(categoryID)?option=\(option)&filter=\(filter)"
        case .deleteContents(contentID: let contentID):
            return "\(baseUrl)/content/\(contentID)"
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
