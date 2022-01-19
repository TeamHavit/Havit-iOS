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
            return "https://asia-northeast3-havit-wesopt29.cloudfunctions.net/api"
        case .production:
            return ""
        }
    }
    
    var token: String {
        return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWRGaXJlYmFzZSI6IiIsImlhdCI6MTY0MjEzOTgwMCwiZXhwIjoxNjQ0NzMxODAwLCJpc3MiOiJoYXZpdCJ9.-VsZ4c5mU96GRwGSLjf-hSiU8HD-LVK8V3a5UszUAWk"
    }
}
