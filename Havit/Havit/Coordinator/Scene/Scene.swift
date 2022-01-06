//
//  Scene.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/06.
//

import UIKit

enum Scene {
    case main(SceneCoordinator)
}

extension Scene: SceneRegisterable {
    func instantiate() -> UIViewController {
        switch self {
        case .main(let coordinator):
            let mainVC = MainViewController()
            mainVC.sceneCoordinator = coordinator
            return mainVC
        }
    }
}
