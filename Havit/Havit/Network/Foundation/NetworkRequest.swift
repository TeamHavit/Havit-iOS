//
//  NetworkRequest.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/14.
//

import Foundation

struct NetworkRequest {
    let url: String
    let headers: [String: String]?
    let body: Data?
    let requestTimeOut: Float?
    let httpMethod: HttpMethod
    
    init(url: String,
         headers: [String: String]? = nil,
         reqBody: Data? = nil,
         reqTimeout: Float? = nil,
         httpMethod: HttpMethod
    ) {
        self.url = url
        self.headers = headers
        self.body = reqBody
        self.requestTimeOut = reqTimeout
        self.httpMethod = httpMethod
        print(url)
    }
    
    func buildURLRequest(with url: URL) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = headers ?? [:]
        urlRequest.httpBody = body
        return urlRequest
    }
}
