//
//  CategoryListDataModel.swift
//  Havit
//
//  Created by 김수연 on 2022/01/14.
//

import Foundation

struct CategoryListData {
    let categoryImageName: String
    let categoryTitle: String
}

extension CategoryListData {
    static let dummy: [CategoryListData] = [
        CategoryListData(categoryImageName: "category_icon", categoryTitle: "UX/UI 아티클1"),
        CategoryListData(categoryImageName: "category_icon", categoryTitle: "UX/UI 아티클2"),
        CategoryListData(categoryImageName: "category_icon", categoryTitle: "UX/UI 아티클3"),
        CategoryListData(categoryImageName: "category_icon", categoryTitle: "UX/UI 아티클4"),
        CategoryListData(categoryImageName: "category_icon", categoryTitle: "UX/UI 아티클5"),
        CategoryListData(categoryImageName: "category_icon", categoryTitle: "UX/UI 아티클6"),
        CategoryListData(categoryImageName: "category_icon", categoryTitle: "UX/UI 아티클7"),
        CategoryListData(categoryImageName: "category_icon", categoryTitle: "UX/UI 아티클8"),
        CategoryListData(categoryImageName: "category_icon", categoryTitle: "UX/UI 아티클9"),
        CategoryListData(categoryImageName: "category_icon", categoryTitle: "UX/UI 아티클10"),
        CategoryListData(categoryImageName: "category_icon", categoryTitle: "UX/UI 아티클11"),
        CategoryListData(categoryImageName: "category_icon", categoryTitle: "UX/UI 아티클12")
    ]
}
