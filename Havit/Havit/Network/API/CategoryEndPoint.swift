//
//  CategoryEndPoint.swift
//  Havit
//
//  Created by 김수연 on 2022/01/18.
//

import Foundation

enum CategoryEndPoint {
    case getCategory

    var requestTimeOut: Float {
        return 20
    }

    var httpMethod: HttpMethod {
        switch self {
        case .getCategory:
            return .GET
        }
    }

    var requestBody: Data? {
        switch self {
        case .getCategory:
            return nil
        }
    }

    func getURL(from environment: APIEnvironment) -> String {
        let baseUrl = environment.baseUrl
        switch self {
        case .getCategory:
            return "\(baseUrl)/category"
        }
    }

    func createRequest(token: String = "", environment: APIEnvironment) -> NetworkRequest {
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json"
        headers["x-auth-token"] = token
        return NetworkRequest(url: getURL(from: environment),
                              headers: headers,
                              reqBody: requestBody,
                              reqTimeout: requestTimeOut,
                              httpMethod: httpMethod)
    }
}
