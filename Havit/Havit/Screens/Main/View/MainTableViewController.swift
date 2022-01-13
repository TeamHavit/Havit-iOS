//
//  MainTableViewController.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/14.
//

import UIKit

import SnapKit

class MainTableViewController: BaseViewController {
    
    // MARK: - property
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.register(cell: ReachRateNotificationTableViewCell.self)
        return tableView
    }()

    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MainTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ReachRateNotificationTableViewCell = tableView.dequeueReusableCell(
            withType: ReachRateNotificationTableViewCell.self, for: indexPath)
        
        return cell
    }
}
