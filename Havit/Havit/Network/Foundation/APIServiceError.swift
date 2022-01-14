//
//  APIServiceError.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/14.
//

import Foundation

enum APIServiceError: Error {
    case urlEncodingError
    case clientError(message: String?)
    case serverError
}
