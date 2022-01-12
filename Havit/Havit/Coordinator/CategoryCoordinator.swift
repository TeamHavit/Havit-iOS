//
//  CategoryCoordinator.swift
//  Havit
//
//  Created by 김수연 on 2022/01/12.
//

import Foundation

final class CategoryCoordinator: BaseCoordinator {

    enum CategoryTransition {
        case guide
    }

    override func start() {
        let category = CategoryViewController()
        category.coordinator = self
        navigationController.pushViewController(category, animated: true)
    }

    func performTransition(to transition: CategoryTransition) {

    }
}
