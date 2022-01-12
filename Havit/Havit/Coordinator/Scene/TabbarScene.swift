//
//  TabbarScene.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/06.
//

import UIKit

enum TabbarScene {
    case main(SceneCoordinator)
}

extension TabbarScene: SceneRegisterable {
    func instantiate() -> UIViewController {
        switch self {
        case .main(let coordinator):
            let mainVC = CategoryContentsViewController()
            mainVC.sceneCoordinator = coordinator
            return mainVC
        }
    }
}
