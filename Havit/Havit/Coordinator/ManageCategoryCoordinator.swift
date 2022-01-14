//
//  ManageCategoryCoordinator.swift
//  Havit
//
//  Created by 김수연 on 2022/01/14.
//

import Foundation

final class ManageCategoryCoordinator: BaseCoordinator {

    enum ManageCategoryTransition {
        case category
    }

    override func start() {
        let manageCategory = ManageCategoryViewController()
        manageCategory.coordinator = self
        navigationController.pushViewController(manageCategory, animated: true)
    }

    func performTransition(to transition: ManageCategoryTransition) {
        switch transition {
        case .category:
            parentCoordinator?.didFinish(coordinator: self)
            navigationController.popViewController(animated: true)
        }
    }
}
