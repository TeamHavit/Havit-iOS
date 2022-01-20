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
    
    private enum ReachSectionCellType: Int, CaseIterable {
        case notification
        case progress
    }
    
    private enum CategorySectionCellType: Int, CaseIterable {
        case category
        case guideline
        case recent
        case recommend
        case logo
    }
    
    private enum MainTableViewSectionType: Int, CaseIterable {
        case reach = 0
        case category = 1
        
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
        tableView.separatorColor = .clear
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
    
    var categories: [Category] = []
    var contents: [Content] = []
    var sites: [Site] = []
    var user: User?
  
    private let searchHeaderView = MainSearchHeaderView()
    
    private var presentableCellTypesInReachSection: [ReachSectionCellType] = []
    
    func appendDummyPresentableCells() {
        presentableCellTypesInReachSection.append(contentsOf: [.notification, .progress])
    }
}

extension MainTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return MainTableViewSectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = MainTableViewSectionType(rawValue: section)
        switch sectionType {
        case .reach:
            return presentableCellTypesInReachSection.count
        case .category:
            return CategorySectionCellType.allCases.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = MainTableViewSectionType(rawValue: indexPath.section)
        switch sectionType {
        case .reach:
            return applyReachSectionCell(tableView, cellForRowAt: indexPath)
        case .category:
            return applyCategorySectionCell(tableView, cellForRowAt: indexPath)
        default:
            return UITableViewCell()
        }
    }
    
    private func applyReachSectionCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = cellTypeInReachSection(at: indexPath)
        switch cellType {
        case .notification:
            let cell = tableView.dequeueReusableCell(withType: ReachRateNotificationTableViewCell.self,
                                                     for: indexPath)
            cell.updateNotificationLabel(to: "도달률이 50% 이하로 떨어졌어요!")
            cell.didTapCloseButton = { [weak self] in
                self?.presentableCellTypesInReachSection.removeAll { type in
                    type == .notification
                }
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            return cell
        case .progress:
            let cell = tableView.dequeueReusableCell(withType: ReachRateTableViewCell.self,
                                                     for: indexPath)
            cell.didTapUnwatchedButton = { [weak self] in
                let unwatchedViewController = MainUnwatchedViewController()
                self?.navigationController?.pushViewController(unwatchedViewController, animated: true)
            }
            
            if let user = user,
               let nickname = user.nickname,
               let totalSeenContentNumber = user.totalSeenContentNumber,
               let totalContentNumber = user.totalContentNumber {
                cell.updateData(name: nickname, watchedCount: totalSeenContentNumber, totalCount: totalContentNumber)
            }
            return cell
        }
    }
    
    private func applyCategorySectionCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = CategorySectionCellType(rawValue: indexPath.row)
        switch cellType {
        case .category:
            let cell = tableView.dequeueReusableCell(withType: CategoryListTableViewCell.self,
                                                     for: indexPath)
            cell.categories = categories
            cell.user = user
            cell.setupCategoryPartLayout(with: categories)
            cell.applyPageControlPages()
            cell.applyUserNickname(to: user?.nickname ?? "")
            cell.didTapOverallButton = { [weak self] in
                let categoryViewController = CategoryViewController(type: .main)
                self?.navigationController?.pushViewController(categoryViewController, animated: true)
            }
            cell.didTapCategory = { [weak self] _ in
                let categoryContentViewController = CategoryContentsViewController()
                self?.navigationController?.pushViewController(categoryContentViewController, animated: true)
            }
            return cell
        case .guideline:
            let cell = tableView.dequeueReusableCell(withType: GuidelineTableViewCell.self,
                                                     for: indexPath)
            return cell
        case .recent:
            let cell = tableView.dequeueReusableCell(withType: RecentContentTableViewCell.self,
                                                     for: indexPath)
            cell.contents = contents
            cell.setupContentPartLayout(with: contents)
            cell.didTapOverallButton = { [weak self] in
                let recentViewController = MainRecentViewController()
                self?.navigationController?.hidesBottomBarWhenPushed = true
                self?.navigationController?.pushViewController(recentViewController, animated: true)
            }
            cell.didTapContentSection = { [weak self] url, isSeen in
                let webViewController = WebViewController(urlString: url, isReadContent: isSeen)
                self?.navigationController?.pushViewController(webViewController, animated: true)
            }
            return cell
        case .recommend:
            let cell = tableView.dequeueReusableCell(withType: RecommendSiteTableViewCell.self,
                                                     for: indexPath)
            cell.sites = sites
            return cell
        case .logo:
            let cell = tableView.dequeueReusableCell(withType: LogoTableViewCell.self,
                                                      for: indexPath)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    private func cellTypeInReachSection(at indexPath: IndexPath) -> ReachSectionCellType {
        return presentableCellTypesInReachSection[indexPath.row]
    }
}

extension MainTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionType = MainTableViewSectionType(rawValue: section)
        switch sectionType {
        case .category:
            searchHeaderView.didTapSearchHeader = { [weak self] in
                let searchContentViewController = SearchContentsViewController()
                let navigationController = UINavigationController(rootViewController: searchContentViewController)
                navigationController.modalTransitionStyle = .crossDissolve
                navigationController.modalPresentationStyle = .overFullScreen
                self?.present(navigationController, animated: true, completion: nil)
            }
            return searchHeaderView
        default:
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return MainTableViewSectionType(rawValue: section)?.headerHeight ?? .zero
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let reachSection = MainTableViewSectionType.reach.rawValue
        let reachSectionHeight = ReachSectionCellType.allCases.enumerated().map { (index, _) in
            tableView.rectForRow(at: IndexPath(row: index, section: reachSection)).height
        }.reduce(CGFloat.zero, +)
        let isScrolledOverReachSection = offsetY >= reachSectionHeight
        
        searchHeaderView.updateBackgroundColor(to: isScrolledOverReachSection ? .whiteGray : .clear)
    }
}
