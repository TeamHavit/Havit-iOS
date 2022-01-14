//
//  SortBottomSheetViewController.swift
//  Havit
//
//  Created by 박예빈 on 2022/01/14.
//

import UIKit

import SnapKit

class SortBottomSheetViewController: BaseViewController {
    
    // MARK: - Property
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "정렬"
        return label
    }()
    
    let sortTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func render() {
        view.addSubview(sortTableView)
        
    }
    
    override func configUI() {
        
    }

}
