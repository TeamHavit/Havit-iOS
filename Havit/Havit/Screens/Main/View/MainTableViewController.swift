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
    
    private enum SectionType: Int, CaseIterable {
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
        tableView.register(cell: ReachRateTableViewCell.self)
        return tableView
    }()
    private let searchHeaderView = MainSearchHeaderView()
    private var isNotificationDeleted: Bool = false
}

extension MainTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = SectionType.init(rawValue: section)
        guard var rowCount = sectionType?.numberOfRows else { return 0 }
        
        switch sectionType {
        case .reach:
            rowCount = isNotificationDeleted ? max(rowCount - 1, 0) : rowCount
        default:
            break
        }
        
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = SectionType.init(rawValue: indexPath.section)
        
        switch section {
        case .reach:
            let row = ReachSection.init(rawValue: indexPath.row)
            guard var rowValue = row?.rawValue else { return UITableViewCell() }
            rowValue = isNotificationDeleted ? rowValue + 1 : rowValue
            
            switch rowValue {
            case 0:
                let cell: ReachRateNotificationTableViewCell = tableView.dequeueReusableCell(
                    withType: ReachRateNotificationTableViewCell.self, for: indexPath)
                cell.updateNotification(to: "도달률이 50% 이하로 떨어졌어요!")
                cell.didTapCloseButton = { [weak self] in
                    self?.isNotificationDeleted = true
                    tableView.deleteRows(at: [IndexPath.init(row: ReachSection.notification.rawValue,
                                                             section: SectionType.reach.rawValue)],
                                         with: .fade)
                }
                return cell
            case 1:
                let cell: ReachRateTableViewCell = tableView.dequeueReusableCell(
                    withType: ReachRateTableViewCell.self, for: indexPath)
                cell.updateData(name: "박태준", watchedCount: 62, totalCount: 145)
                return cell
            default:
                return UITableViewCell()
            }
        case .category:
            return UITableViewCell()
        case .none:
            return UITableViewCell()
        }
    }
}

extension MainTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = SectionType.init(rawValue: section)
        switch section {
        case .category:
            return searchHeaderView
        default:
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return SectionType.init(rawValue: section)?.headerHeight ?? .zero
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return SectionType.init(rawValue: section)?.footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return SectionType.init(rawValue: section)?.footerHeight ?? .zero
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let reachSection = SectionType.reach.rawValue
        let reachSectionHeight = ReachSection.allCases.enumerated().map { (index, _) in
            tableView.rectForRow(at: IndexPath(row: index, section: reachSection)).height
        }.reduce(CGFloat.zero, +)
        let isScrolledOverReachSection = offsetY >= reachSectionHeight
        
        searchHeaderView.updateBackgroundColor(to: isScrolledOverReachSection ? .whiteGray : .clear)
    }
}
