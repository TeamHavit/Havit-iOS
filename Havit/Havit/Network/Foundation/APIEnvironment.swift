//
//  APIEnvironment.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/14.
//

import Foundation

enum APIEnvironment: String, CaseIterable {
    case development
    case production
}

extension APIEnvironment {
    var baseUrl: String {
        switch self {
        case .development:
            return ""
        case .production:
            return ""
        }
    }
}
