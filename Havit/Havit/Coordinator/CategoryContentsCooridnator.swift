//
//  CategoryContentsCooridnator.swift
//  Havit
//
//  Created by 박예빈 on 2022/01/14.
//

import Foundation

final class CategoryContentsCoordinator: BaseCoordinator {

    enum CategoryContentsTransition {
        case pop
    }

    override func start() {
        let categoryContents = CategoryContentsViewController()
        categoryContents.coordinator = self
        navigationController.pushViewController(categoryContents, animated: true)
    }

    func previous(to transition: CategoryContentsTransition) {
        switch transition {
        case .pop:
            parentCoordinator?.didFinish(coordinator: self)
            navigationController.popViewController(animated: true)
        }
    }
}
