//
//  WebViewCoordinator.swift
//  Havit
//
//  Created by 강수진 on 2022/01/14.
//

import Foundation

final class WebViewCoordinator: BaseCoordinator {
    func start(with url: String) {
        let webViewController = WebViewController(url: url)
        webViewController.coordinator = self
        navigationController.pushViewController(webViewController, animated: true)
    }
}
