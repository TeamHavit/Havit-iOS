//
//  RequestCategory.swift
//  ShareExtension
//
//  Created by Noah on 2022/01/22.
//

import Foundation

struct RequestCategory {
    var title: String?
    var imageId: Int?

    init(title: String?) {
        self.title = title
        self.imageId = nil
    }
}
