//
//  APIService.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/14.
//

import Foundation

final class APIService: Requestable {
    var requestTimeOut: Float = 30
    
    func request<T: Decodable>(_ request: NetworkRequest) async throws -> T? {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = TimeInterval(request.requestTimeOut ?? requestTimeOut)
        
        guard let encodedUrl = request.url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encodedUrl) else {
                  throw APIServiceError.urlEncodingError
              }
        
        let (data, response) = try await URLSession.shared.data(for: request.buildURLRequest(with: url))
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<500) ~= httpResponse.statusCode else {
                  throw APIServiceError.serverError
              }
        
        let decoder = JSONDecoder()
        let baseModelData = try decoder.decode(GenericResponse<T>.self, from: data)
        if baseModelData.success ?? false {
            return baseModelData.data
        } else {
            throw APIServiceError.clientError(message: baseModelData.message)
        }
    }
}
