//
//  CategoryServiceable.swift
//  Havit
//
//  Created by 김수연 on 2022/01/18.
//

import Foundation

protocol CategorySeriviceable {
    func getCategory() async throws -> [Category]?
}
