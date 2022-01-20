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

enum MorePanModalButtonType {
    case editTitle, share, goToCategory, setAlarm, delete
}

enum ContentsSortType: String {
    case created_at = "created_at"
    case reverse = "reverse"
    case seen_at = "seen_at"
}

enum ContentsFilterType: String {
    case all = "all"
    case notSeen = "notSeen"
    case seen = "seen"
    case alarm = "alarm"
}
