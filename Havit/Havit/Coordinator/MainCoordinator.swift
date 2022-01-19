//
//  MainCoordinator.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/10.
//

import Foundation

final class MainCoordinator: BaseCoordinator {
    
    enum MainTransition {
        case unwatched
    }

    override func start() {
        let mainViewController = MainViewController()
        mainViewController.coordinator = self
        navigationController.pushViewController(mainViewController, animated: true)
    }
    
    func performTransition(to transition: MainTransition) {
        switch transition {
        case .unwatched:
            let coordinator = UnwatchedCoordinator(navigationController: navigationController)
            start(coordinator: coordinator)
        }
    }
}
