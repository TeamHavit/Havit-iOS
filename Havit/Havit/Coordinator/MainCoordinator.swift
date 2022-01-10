//
//  MainCoordinator.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/10.
//

import Foundation

enum MainTransition {
    case guide
}

final class MainCoordinator: BaseCoordinator {

    override func start() {
        let main = MainViewController()
        main.coordinator = self
        navigationController.pushViewController(main, animated: true)
    }
    
    func performTransition(to transition: MainTransition) {
        
    }
}
