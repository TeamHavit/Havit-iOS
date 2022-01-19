//
//  SearchServiceable.swift
//  Havit
//
//  Created by 박예빈 on 2022/01/19.
//

import Foundation

protocol SearchContentsSeriviceable {
    func getSearchResult(keyword: String) async throws -> [SearchContents]?
}
