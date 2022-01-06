//
//  BaseViewModel.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/06.
//

import Foundation

import RxSwift
import RxCocoa

class BaseViewModel: NSObject {
    let sceneCoordinator: SceneCoordinatorType
    
    init(sceneCoordinator: SceneCoordinatorType) {
        self.sceneCoordinator = sceneCoordinator
    }
}
