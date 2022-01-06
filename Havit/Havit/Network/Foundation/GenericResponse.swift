//
//  GenericResponse.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/06.
//

import Foundation

struct GenericResponse<T: Decodable>: Decodable {
    var status: Int
    var success: Bool
    var message: String?
    var data: T?
    
    var statusCase: NetworkStatus? {
        return NetworkStatus(rawValue: status)
    }
    
    enum CodingKeys: String, CodingKey {
        case message
        case data
        case status
        case success
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        data = (try? values.decode(T.self, forKey: .data)) ?? nil
        status = (try? values.decode(Int.self, forKey: .status)) ?? 0
        success = (try? values.decode(Bool.self, forKey: .success)) ?? false
    }
}

struct GenericArrayResponse<T: Decodable>: Decodable {
    let status: Int
    let message: String?
    let success: Bool?
    let data: [T]?

    var statusCase: NetworkStatus? {
        return NetworkStatus(rawValue: status)
    }
    
    enum CodingKeys: String, CodingKey {
        case message
        case data
        case status
        case success
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        data = (try? values.decode([T].self, forKey: .data)) ?? []
        status = (try? values.decode(Int.self, forKey: .status)) ?? 0
        success = (try? values.decode(Bool.self, forKey: .success)) ?? false
    }
}

struct VoidType: Decodable {}
