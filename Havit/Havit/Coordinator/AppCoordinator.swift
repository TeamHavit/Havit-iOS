//
//  AppCoordinator.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/10.
//

import Foundation

final class AppCoordinator: BaseCoordinator {
    override func start() {
        let coordinator = CategoryContentsCoordinator(navigationController: navigationController)
        start(coordinator: coordinator)
    }
}
