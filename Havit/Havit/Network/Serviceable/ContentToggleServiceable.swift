//
//  ContentToggleServiceable.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/20.
//

import Foundation

protocol ContentToggleServiceable {
    func patchContentToggle(contentId: Int) async throws -> ContentToggle?
}
