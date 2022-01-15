//
//  WebViewCoordinator.swift
//  Havit
//
//  Created by 강수진 on 2022/01/14.
//

import Foundation

final class WebViewCoordinator: BaseCoordinator {
    
    enum WebViewTransition {
        case previous
    }
    
    func start(with urlString: String) {
        let webViewController = WebViewController(urlString: urlString)
        webViewController.coordinator = self
        navigationController.pushViewController(webViewController, animated: true)
    }
    
    func performTransition(to transition: WebViewTransition) {
        switch transition {
        case .previous:
            parentCoordinator?.didFinish(coordinator: self)
            navigationController.popViewController(animated: true)
        }
    }
}
