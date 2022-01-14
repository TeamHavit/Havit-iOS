//
//  CategoryContentsCooridnator.swift
//  Havit
//
//  Created by 박예빈 on 2022/01/14.
//

import Foundation

final class CategoryContentsCoordinator: BaseCoordinator {

    enum CategoryContentsTransition {
        case main
    }

    override func start() {
        let categoryContents = CategoryContentsViewController()
        categoryContents.coordinator = self
        navigationController.pushViewController(categoryContents, animated: true)
    }

    func performTransition(to transition: CategoryContetnsTransition) {
        switch transition {
        case .main:
            parentCoordinator?.didFinish(coordinator: self)
            navigationController.popViewController(animated: true)
        }
    }
}
