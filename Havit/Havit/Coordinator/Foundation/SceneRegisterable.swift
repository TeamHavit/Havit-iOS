//
//  SceneRegisterable.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/06.
//

import UIKit

protocol SceneRegisterable {
    func instantiate() -> UIViewController
}

extension SceneRegisterable where Self == Scene {
    func instantiate() -> UIViewController {

        return UIViewController()
    }
}
