//
//  MainCoordinator.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/10.
//

import Foundation

final class MainCoordinator: BaseCoordinator {
    
    enum MainTransition {
        case guide
    }

    override func start() {
        let main = MainViewController()
        main.coordinator = self
        navigationController.pushViewController(main, animated: true)
    }
    
    func performTransition(to transition: MainTransition) {
        
    }
}
