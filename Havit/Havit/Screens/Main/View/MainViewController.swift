//
//  MainViewController.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/06.
//

import UIKit

import SnapKit

final class MainViewController: MainTableViewController {
    
    // MARK: - property
    
    private let topView = MainTopView()
    
    weak var coordinator: MainCoordinator?
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func render() {
        view.addSubViews([topView, tableView])
        
        topView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(44)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
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
