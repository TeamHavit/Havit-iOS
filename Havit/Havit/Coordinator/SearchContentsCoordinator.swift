//
//  SearchContentsCoordinator.swift
//  Havit
//
//  Created by 박예빈 on 2022/01/17.
//

import Foundation

final class SearchContentsCoordinator: BaseCoordinator {

    enum SearchContentsTransition {
        case previous
    }

    override func start() {
        let searchContents = SearchContentsViewController()
        searchContents.coordinator = self
        navigationController.pushViewController(searchContents, animated: true)
    }

    func previous(to transition: SearchContentsTransition) {
        switch transition {
        case .previous:
            parentCoordinator?.didFinish(coordinator: self)
            navigationController.popViewController(animated: true)
        }
    }
}
