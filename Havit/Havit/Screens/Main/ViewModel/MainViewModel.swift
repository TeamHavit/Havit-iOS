//
//  MainViewModel.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/06.
//

import Foundation

import RxSwift
import RxCocoa

final class MainViewModel {
    
    struct Input {
        let viewDidLoad: PublishSubject<Void>
    }
    
    struct Output {
        let getCategory: Driver<[Category]?>
        let getRecentContent: Driver<[Content]?>
        let getRecommendSite: Driver<[Site]?>
    }
    
//    func transform(input: Input) -> Output {
//
//    }
}

extension MainViewModel {
    
}
