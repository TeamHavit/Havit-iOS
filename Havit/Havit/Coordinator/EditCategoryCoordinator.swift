//
//  EditCategoryCoordinator.swift
//  Havit
//
//  Created by 김수연 on 2022/01/16.
//

import Foundation

final class EditCategoryCoordinator: BaseCoordinator {

    enum EditCategoryTransition {
        case previous
    }

    override func start() {
        let editCategory = EditCategoryViewController()
        editCategory.coordinator = self
        navigationController.pushViewController(editCategory, animated: true)
    }

    func performTransition(to transition: EditCategoryTransition) {
        switch transition {
        case .previous:
            parentCoordinator?.didFinish(coordinator: self)
            navigationController.popViewController(animated: true)
        }
    }
}
