//
//  CategoryEndPoint.swift
//  Havit
//
//  Created by 김수연 on 2022/01/18.
//

import Foundation

enum CategoryEndPoint {
    case getCategory
    case editCategory(categoryId: Int, title: String, imageId: Int)

    var requestTimeOut: Float {
        return 20
    }

    var httpMethod: HttpMethod {
        switch self {
        case .getCategory:
            return .GET
        case .editCategory:
            return .PATCH
        }
    }

    var requestBody: Data? {
        switch self {
        case .getCategory:
            return nil
        case .editCategory(_, let title, let imageId):
            let parameters = ["title": title,
                              "imageId": imageId.description]
            return parameters.encode()
        }
    }

    func getURL(from environment: APIEnvironment) -> String {
        let baseUrl = environment.baseUrl
        switch self {
        case .getCategory:
            return "\(baseUrl)/category"
        case .editCategory(let categoryId, _, _):
            return "\(baseUrl)/category/\(categoryId)"
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
