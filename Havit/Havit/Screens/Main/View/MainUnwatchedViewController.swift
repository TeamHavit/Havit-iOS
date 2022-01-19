//
//  MainUnwatchedViewController.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/19.
//

import UIKit

import SnapKit

final class MainUnwatchedViewController: BaseViewController {
    
    // MARK: - property
    
    weak var coordinator: UnwatchedCoordinator?
    
    override func configUI() {
        super.configUI()
        view.backgroundColor = .primaryBlack
    }
}
