//
//  SearchContentsEndPoint.swift
//  Havit
//
//  Created by 박예빈 on 2022/01/19.
//

import Foundation

enum SearchContentsEndPoint {
    case getSearchResult(keyword: String)
    
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
        switch self {
        case .getSearchResult(let keyword):
            let urlString = baseUrl + "/content/search/?keyword=\(keyword)"
            let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let url = URL(string: encodedString)!
            print(encodedString)
            
            var components = URLComponents(string: baseUrl)
            let keyword = URLQueryItem(name: "keyword", value: "keyword")
            components?.queryItems = [keyword]

            let newURL = components?.url
            print(newURL)
            // print(String(newURL))
            return encodedString
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
