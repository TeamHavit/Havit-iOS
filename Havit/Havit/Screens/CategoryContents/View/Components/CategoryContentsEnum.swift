//
//  CategoryContentsEnum.swift
//  Havit
//
//  Created by 박예빈 on 2022/01/19.
//

enum GridType {
    case grid, grid2xN, grid1xN
}

enum SortType {
    case latestOrder
    case pastOrder
    case viewOrder
}

enum FilterType: Int {
    case all
    case unwatched
    case watched
    case alarm
}
