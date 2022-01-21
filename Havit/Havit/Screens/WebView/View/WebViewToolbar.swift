//
//  WebViewToolbar.swift
//  Havit
//
//  Created by 강수진 on 2022/01/16.
//

import UIKit

final class WebViewToolbar: UIToolbar {
    
    enum Size {
        static let toolbarHeight: CGFloat = 44
    }
    
    // MARK: - property
    
    let backBarButton = UIBarButtonItem(image: ImageLiteral.iconBackspaceGray.withRenderingMode(.alwaysOriginal),
                                        style: .plain,
                                        target: nil,
                                        action: nil)
    let forwardBarButton = UIBarButtonItem(image: ImageLiteral.iconForwardGray.withRenderingMode(.alwaysOriginal),
                                           style: .plain,
                                           target: nil,
                                           action: nil)
    let shareBarButton = UIBarButtonItem(image: ImageLiteral.iconShare.withRenderingMode(.alwaysOriginal),
                                         style: .plain,
                                         target: nil,
                                         action: nil)
    let safariBarButton = UIBarButtonItem(image: ImageLiteral.iconSafari.withRenderingMode(.alwaysOriginal),
                                          style: .plain,
                                          target: nil,
                                          action: nil)
    let checkReadBarButton = UIBarButtonItem(image: ImageLiteral.iconContentsUnread.withRenderingMode(.alwaysOriginal),
                                             style: .plain,
                                             target: nil,
                                             action: nil)
    
    // MARK: - init
    
    convenience init(canCheckRead: Bool) {
        let frame = CGRect(origin: .zero,
                           size: CGSize(width: UIScreen.main.bounds.height,
                                        height: Size.toolbarHeight))
        self.init(frame: frame)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil,
                                            action: nil)
        var toolbarItems = [backBarButton,
                            forwardBarButton,
                            shareBarButton,
                            safariBarButton]
        if canCheckRead {
            toolbarItems.append(checkReadBarButton)
        }
        
        toolbarItems = toolbarItems.reduce([]) { (barButtonItems, barButtonItem) in
            return barButtonItems + [barButtonItem, flexibleSpace]
        }
        toolbarItems.removeLast()
        self.setItems(toolbarItems,
                      animated: false)
        self.isTranslucent = false
        self.barTintColor = .whiteGray
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
