//
//  ShareServiceable.swift
//  Havit
//
//  Created by Noah on 2022/01/21.
//

import Foundation

protocol ShareServiceable {
    func getTargetContents(targetUrl: String) async throws -> SaveTargetContent?
}
