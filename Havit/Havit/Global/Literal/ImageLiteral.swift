//
//  ImageLiteral.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/06.
//

import UIKit

enum ImageLiteral {
    static var btnAdd: UIImage { .load(named: "btnAdd")}
    static var btnAlarm: UIImage { .load(named: "btnAlarm")}
    static var btnAlarmGray: UIImage { .load(named: "btnAlarmGray")}
    static var btnBackBlack: UIImage { .load(named: "btnBackBlack")}
    static var btnBackspaceBlack: UIImage { .load(named: "btnBackspaceBlack")}
    static var btnContentsRead: UIImage { .load(named: "btnContentsRead")}
    static var btnContentsUnread: UIImage { .load(named: "btnContentsUnread")}
    static var btnForwardBlack: UIImage { .load(named: "btnForwardBlack")}
    static var btnMore: UIImage { .load(named: "btnMore")}
    static var btnRefresh: UIImage { .load(named: "btnRefresh")}
    static var btnSafari: UIImage { .load(named: "btnSafari")}
    
    static var iconAlarmtagEnd: UIImage { .load(named: "iconAlarmtagEnd")}
    static var iconAlarmtagPuple: UIImage { .load(named: "iconAlarmtagPuple")}
    static var iconCategory: UIImage { .load(named: "iconCategory")}
    static var iconCategoryAdd: UIImage { .load(named: "iconCategoryAdd")}
    static var iconCategoryMove: UIImage { .load(named: "iconCategoryMove")}
    static var iconCategorySelected: UIImage { .load(named: "iconCategorySelected")}
    static var iconCategoryUnselected: UIImage { .load(named: "iconCategoryUnselected")}
    static var iconCheck: UIImage { .load(named: "iconCheck")}
    static var iconChipGray: UIImage { .load(named: "iconChipGray")}
    static var iconDelete: UIImage { .load(named: "iconDelete")}
    static var iconDropBlack: UIImage { .load(named: "iconDropBlack")}
    static var iconEdit: UIImage { .load(named: "iconEdit")}
    static var iconGoGray: UIImage { .load(named: "iconGoGray")}
    static var iconHandGray: UIImage { .load(named: "iconHandGray")}
    static var iconHomeSelected: UIImage { .load(named: "iconHomeSelected")}
    static var iconHomeUnselected: UIImage { .load(named: "iconHomeUnselected")}
    static var iconLayout2: UIImage { .load(named: "iconLayout2")}
    static var iconLayout3: UIImage { .load(named: "iconLayout3")}
    static var iconLayout4: UIImage { .load(named: "iconLayout4")}
    static var iconMypageSelected: UIImage { .load(named: "iconMypageSelected")}
    static var iconMypageUnselected: UIImage { .load(named: "iconMypageUnselected")}
    static var iconNoticeIcon: UIImage { .load(named: "iconNoticeIcon")}
    static var iconSearch: UIImage { .load(named: "iconSearch")}
    static var iconShare: UIImage { .load(named: "iconShare")}
    static var iconUpdown: UIImage { .load(named: "iconUpdown")}
    static var iconBackWhite: UIImage { .load(named: "iconBackWhite")}
    static var iconNoticeGray: UIImage { .load(named: "iconNoticeGray")}
    static var iconCategoryEdit: UIImage { .load(named: "iconCategoryEdit")}
    
    static var imgCategoryNone: UIImage { .load(named: "imgCategoryNone")}
    static var imgDummyContent: UIImage { .load(named: "imgDummyContent")}
    static var imgGraphicNoalarm: UIImage { .load(named: "imgGraphicNoalarm")}
    static var imgGraphicNocategory: UIImage { .load(named: "imgGraphicNocategory")}
    static var imgGraphicNocontents: UIImage { .load(named: "imgGraphicNocontents")}
    static var imgGuide: UIImage { .load(named: "imgGuide")}
    static var imgLogoBox: UIImage { .load(named: "imgLogoBox")}
    static var imgSearch: UIImage { .load(named: "imgSearch")}
    static var imgTextLogo: UIImage { .load(named: "imgTextLogo")}
    static var imgTextLogoGray: UIImage { .load(named: "imgTextLogoGray")}
    static var imgCategoryTip: UIImage { .load(named: "imgCategoryTip")}
    static var imgcardCategoryLine: UIImage { .load(named: "imgcardCategoryLine")}
}

extension UIImage {
    static func load(named imageName: String) -> UIImage {
        guard let image = UIImage(named: imageName, in: nil, compatibleWith: nil) else {
            return UIImage()
        }
        image.accessibilityIdentifier = imageName
        return image
    }
    
    func resize(to size: CGSize) -> UIImage {
        let image = UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
        return image
    }
}
