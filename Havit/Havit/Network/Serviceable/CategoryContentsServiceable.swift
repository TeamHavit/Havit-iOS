//
//  CategoryContentsServiceable.swift
//  Havit
//
//  Created by 박예빈 on 2022/01/20.
//

import Foundation

protocol CategoryContentsSeriviceable {
    func getCategoryContents() async throws -> [CategoryContents]?
}
