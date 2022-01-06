//
//  SceneCoordinatorType.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/06.
//

import RxSwift

protocol SceneCoordinatorType {
    @discardableResult
    func transition(to scene: SceneRegisterable, using style: TransitionStyle, animated: Bool) -> Completable
    
    @discardableResult
    func close(animated: Bool) -> Completable
}

