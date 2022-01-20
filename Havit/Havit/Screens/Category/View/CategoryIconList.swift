//
//  CategoryListDataModel.swift
//  Havit
//
//  Created by 김수연 on 2022/01/14.
//

import Foundation
import UIKit

struct CategoryIconList {
    let categoryIcon: UIImage
}

extension CategoryIconList {
    static let iconList: [CategoryIconList] = [
        CategoryIconList(categoryIcon: ImageLiteral.icon3d1),
        CategoryIconList(categoryIcon: ImageLiteral.icon3d2),
        CategoryIconList(categoryIcon: ImageLiteral.icon3d3),
        CategoryIconList(categoryIcon: ImageLiteral.icon3d4),
        CategoryIconList(categoryIcon: ImageLiteral.icon3d5),
        CategoryIconList(categoryIcon: ImageLiteral.icon3d6),
        CategoryIconList(categoryIcon: ImageLiteral.icon3d7),
        CategoryIconList(categoryIcon: ImageLiteral.icon3d8),
        CategoryIconList(categoryIcon: ImageLiteral.icon3d9),
        CategoryIconList(categoryIcon: ImageLiteral.icon3d10),
        CategoryIconList(categoryIcon: ImageLiteral.icon3d11),
        CategoryIconList(categoryIcon: ImageLiteral.icon3d12),
        CategoryIconList(categoryIcon: ImageLiteral.icon3d13),
        CategoryIconList(categoryIcon: ImageLiteral.icon3d14),
        CategoryIconList(categoryIcon: ImageLiteral.icon3d15)
    ]
}
