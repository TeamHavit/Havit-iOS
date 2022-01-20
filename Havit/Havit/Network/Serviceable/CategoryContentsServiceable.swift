//
//  CategoryContentsServiceable.swift
//  Havit
//
//  Created by 박예빈 on 2022/01/20.
//

import Foundation

protocol CategoryContentsSeriviceable {
    func getCategoryContents(option: String, filter: String) async throws -> [CategoryContents]?
}
