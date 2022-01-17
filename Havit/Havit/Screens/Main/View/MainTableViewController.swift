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
        case logo
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
        
        var headerHeight: CGFloat {
            switch self {
            case .category:
                return Size.headerHeight
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
        tableView.register(cell: CategoryListTableViewCell.self)
        tableView.register(cell: GuidelineTableViewCell.self)
        tableView.register(cell: RecentContentTableViewCell.self)
        tableView.register(cell: RecommendSiteTableViewCell.self)
        tableView.register(cell: LogoTableViewCell.self)
        return tableView
    }()
    private let headerView = MainSearchHeaderView()
    private var isDeleted: Bool = false
}

extension MainTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = Section.init(rawValue: section)
        guard var rowCount = section?.numberOfRows else { return 0 }
        
        switch section {
        case .reach:
            rowCount = isDeleted ? max(rowCount - 1, 0) : rowCount
        default:
            break
        }
        
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = Section.init(rawValue: indexPath.section)
        
        switch section {
        case .reach:
            let row = ReachSection.init(rawValue: indexPath.row)
            guard var rowValue = row?.rawValue else { return UITableViewCell() }
            rowValue = isDeleted ? rowValue + 1 : rowValue
            
            return reachSectionCell(tableView,
                                    cellForRowAt: indexPath,
                                    currentRowValue: rowValue)
        case .category:
            let row = CategorySection.init(rawValue: indexPath.row)
            
            return categorySectionCell(tableView,
                                       cellForRowAt: indexPath,
                                       currentRowType: row)
        case .none:
            return UITableViewCell()
        }
    }
    
    private func reachSectionCell(_ tableView: UITableView,
                                  cellForRowAt indexPath: IndexPath,
                                  currentRowValue rowValue: Int) -> UITableViewCell {
        switch rowValue {
        case 0:
            let cell: ReachRateNotificationTableViewCell = tableView.dequeueReusableCell(
                withType: ReachRateNotificationTableViewCell.self, for: indexPath)
            cell.updateNotification(to: "도달률이 50% 이하로 떨어졌어요!")
            cell.didTapCloseButton = {
                self.isDeleted = true
                tableView.deleteRows(at: [IndexPath.init(row: ReachSection.notification.rawValue, section: Section.reach.rawValue)], with: .fade)
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
    }
    
    private func categorySectionCell(_ tableView: UITableView,
                                     cellForRowAt indexPath: IndexPath,
                                     currentRowType rowType: CategorySection?) -> UITableViewCell {
        switch rowType {
        case .category:
            let cell: CategoryListTableViewCell = tableView.dequeueReusableCell(
                withType: CategoryListTableViewCell.self, for: indexPath)
            return cell
        case .guideline:
            let cell: GuidelineTableViewCell = tableView.dequeueReusableCell(withType: GuidelineTableViewCell.self, for: indexPath)
            return cell
        case .recent:
            let cell: RecentContentTableViewCell = tableView.dequeueReusableCell(withType: RecentContentTableViewCell.self, for: indexPath)
            return cell
        case .recommend:
            let cell: RecommendSiteTableViewCell = tableView.dequeueReusableCell(withType: RecommendSiteTableViewCell.self, for: indexPath)
            return cell
        default:
            let cell: LogoTableViewCell = tableView.dequeueReusableCell(withType: LogoTableViewCell.self, for: indexPath)
            return cell
        }
    }
}

extension MainTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = Section.init(rawValue: section)
        switch section {
        case .category:
            return headerView
        default:
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Section.init(rawValue: section)?.headerHeight ?? .zero
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let notificationFrame = tableView.rectForRow(at: IndexPath(row: 0, section: 0))
        let rateFrame = tableView.rectForRow(at: IndexPath(row: 1, section: 0))
        let sectionHeight = notificationFrame.height + rateFrame.height
        let isScrolledOverReachSection = offsetY >= sectionHeight
        
        headerView.updateBackgroundColor(to: isScrolledOverReachSection ? .whiteGray : .clear)
    }
}
