//
//  RootScene.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/06.
//

import UIKit

enum RootScene {
    
}

extension RootScene: SceneRegisterable {
    func instantiate() -> UIViewController {
        return UIViewController()
    }
}
