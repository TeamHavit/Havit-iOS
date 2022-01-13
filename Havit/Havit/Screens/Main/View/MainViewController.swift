//
//  MainViewController.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/06.
//

import UIKit

import SnapKit

final class MainViewController: MainTableViewController {
    
    // MARK: - Property
    
    private let topView = MainTopView()
    
    weak var coordinator: MainCoordinator?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func render() {
        view.addSubViews([topView])
        
        topView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(44)
        }
    }
    
    override func configUI() {
        view.backgroundColor = .whiteGray
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct Preview: PreviewProvider {
    static var previews: some View {
        MainViewController().showPreview(.iPhone12ProMax)
    }
}
#endif
