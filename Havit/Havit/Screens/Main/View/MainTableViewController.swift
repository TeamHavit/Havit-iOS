//
//  MainTableViewController.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/14.
//

import UIKit

import SnapKit

class MainTableViewController: BaseViewController {
    
    enum Size {
        static let headerHeight: CGFloat = 50
        static let footerHeight: CGFloat = 100
    }
    
    enum ReachSection: Int, CaseIterable {
        case notification
        case progress
    }
    
    enum CategorySection: Int, CaseIterable {
        case category
        case guideline
        case recent
        case recommend
    }
    
    // MARK: - property
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.sectionHeaderTopPadding = 0
        tableView.estimatedRowHeight = 44
        tableView.showsVerticalScrollIndicator = false
        tableView.register(cell: ReachRateNotificationTableViewCell.self)
        return tableView
    }()
}

extension MainTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return ReachSection.allCases.count
        case 1:
            return CategorySection.allCases.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ReachRateNotificationTableViewCell = tableView.dequeueReusableCell(
            withType: ReachRateNotificationTableViewCell.self, for: indexPath)
        
        return cell
    }
}

extension MainTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 1:
            return MainTopView()
        default:
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 1:
            return Size.headerHeight
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        switch section {
        case 1:
            return MainTopView()
        default:
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 1:
            return Size.footerHeight
        default:
            return 0
        }
    }
}
