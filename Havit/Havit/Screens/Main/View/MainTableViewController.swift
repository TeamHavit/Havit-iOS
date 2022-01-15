//
//  MainTableViewController.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/14.
//

import UIKit

import SnapKit

class MainTableViewController: BaseViewController {
    
    private enum Size {
        static let headerHeight: CGFloat = 94
        static let footerHeight: CGFloat = 122
    }
    
    private enum ReachSection: Int, CaseIterable {
        case notification
        case progress
    }
    
    private enum CategorySection: Int, CaseIterable {
        case category
        case guideline
        case recent
        case recommend
    }
    
    private enum Section: Int, CaseIterable {
        case reach
        case category
        
        var numberOfRows: Int {
            switch self {
            case .reach:
                return ReachSection.allCases.count
            case .category:
                return CategorySection.allCases.count
            }
        }
        
        var headerView: UIView {
            switch self {
            case .category:
                return MainSearchHeaderView()
            default:
                return UIView()
            }
        }
        
        var headerHeight: CGFloat {
            switch self {
            case .category:
                return Size.headerHeight
            default:
                return .zero
            }
        }
        
        var footerView: UIView {
            switch self {
            case .category:
                return MainFooterView()
            default:
                return UIView()
            }
        }
        
        var footerHeight: CGFloat {
            switch self {
            case .category:
                return Size.footerHeight
            default:
                return .zero
            }
        }
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
    
    var isDeleted: Bool = false
}

extension MainTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = Section.init(rawValue: section)
        var rowCount = section?.numberOfRows ?? 0
        
        switch section {
        case .reach:
            rowCount = isDeleted ? rowCount - 1 : rowCount
        default:
            break
        }
        
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ReachRateNotificationTableViewCell = tableView.dequeueReusableCell(
            withType: ReachRateNotificationTableViewCell.self, for: indexPath)
        cell.updateNotification(to: "도달률이 50% 이하로 떨어졌어요!")
        cell.rx.didTapCloseButton
            .bind(onNext: { [weak self] in
                self?.isDeleted = true
                tableView.deleteRows(
                    at: [IndexPath.init(row: ReachSection.notification.rawValue,
                                        section: Section.reach.rawValue)],
                    with: .fade
                )
            })
            .disposed(by: disposeBag)
        return cell
    }
}

extension MainTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return Section.init(rawValue: section)?.headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Section.init(rawValue: section)?.headerHeight ?? .zero
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return Section.init(rawValue: section)?.footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return Section.init(rawValue: section)?.footerHeight ?? .zero
    }
}
