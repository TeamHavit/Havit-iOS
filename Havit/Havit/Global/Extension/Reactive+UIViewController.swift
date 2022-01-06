//
//  Reactive+UIViewController.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/06.
//

import UIKit

import RxCocoa
import RxSwift

extension RxSwift.Reactive where Base: UIViewController {
    public var viewDidLoad: Observable<Void> {
        return methodInvoked(#selector(UIViewController.viewDidLoad))
            .map { _ in }
    }
    
    public var viewWillAppear: Observable<Bool> {
        return methodInvoked(#selector(UIViewController.viewWillAppear))
            .map { $0.first as? Bool ?? false }
    }
}
