//
//  UnwatchedCoordinator.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/19.
//

import Foundation

final class UnwatchedCoordinator: BaseCoordinator {
    
    enum UnwatchedTransition {
        case previous
    }

    override func start() {
        let unwatchedViewController = MainUnwatchedViewController()
        unwatchedViewController.coordinator = self
        navigationController.pushViewController(unwatchedViewController, animated: true)
    }
    
    func performTransition(to transition: UnwatchedTransition) {
        switch transition {
        case .previous:
            removeChildCoordinators()
            parentCoordinator?.didFinish(coordinator: self)
            navigationController.popViewController(animated: true)
        }
    }
}
