//
//  GenericResponse.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/06.
//

import Foundation

struct GenericResponse<T: Decodable>: Decodable {
    var status: Int?
    var success: Bool?
    var message: String?
    var data: T?
    
    var statusCase: NetworkStatus? {
        return NetworkStatus(rawValue: status ?? 0)
    }
}
