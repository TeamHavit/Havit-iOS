//
//  Scene.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/06.
//

import UIKit

enum Scene {
    case main(MainViewModel)
}

extension Scene: SceneRegisterable {
    func instantiate() -> UIViewController {
        switch self {
        case .main(let viewModel):
            return MainViewController(viewModel: viewModel)
        }
    }
}
