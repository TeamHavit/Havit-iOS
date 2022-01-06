//
//  NetworkStatus.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/06.
//

import Foundation

enum NetworkStatus: Int {
    case okay = 200
    case created = 201
    case noContent = 204
    case badRequest = 400
    case unAuthorized = 401
    case nullValue = 402
    case forbidden = 403
    case notFound = 404
    case conflict = 409
    case internalServerError = 500
    case serviceUnavailable = 503
    case dbError = 600
}
