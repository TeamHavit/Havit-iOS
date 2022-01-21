//
//  SortPanModalViewController.swift
//  Havit
//
//  Created by 박예빈 on 2022/01/14.
//

import UIKit

import PanModal
import SnapKit

class SortPanModalViewController: BaseViewController, PanModalPresentable {
    
    var panScrollable: UIScrollView? {
        return nil
    }
    
    let categoryContentsService: CategoryContentsSeriviceable = CategoryContentsService(apiService: APIService(),
                                                                environment: .development)
    private var categoryContents: [Content] = []
    var previousViewController: CategoryContentsViewController?
    
    var isFromAllCategory: Bool = true
    var categoryID: String = "0"
    
    var shortFormHeight: PanModalHeight = .contentHeight(278)
    var longFormHeight: PanModalHeight = .contentHeight(278)
    var cornerRadius: CGFloat = 0
    
    let sortList = ["최신순", "과거순", "최근 조회순"]
    var option: String?
    var filter: String?
    var contentsSortType: ContentsSortType = .createdAt
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "정렬"
        label.font = UIFont.font(.pretendardSemibold, ofSize: 17)
        label.textColor = .primaryBlack
        label.textAlignment = .center
        return label
    }()
    
    let sortTableView: UITableView = {
        var tableView = UITableView()
        tableView.register(cell: SortPanModalTableViewCell.self, forCellReuseIdentifier: SortPanModalTableViewCell.className)
        // sortTableView.separatorStyle = .none
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegations()
    }
    
    override func render() {
        view.addSubViews([titleLabel, sortTableView])
        
        titleLabel.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(view)
            $0.height.equalTo(60)
        }
        
        sortTableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.trailing.equalTo(view)
            $0.height.equalTo(147)
        }
    }
    
    override func configUI() {
        view.backgroundColor = .white
        sortTableView.separatorStyle = .none
    }
    
    private func setDelegations() {
        sortTableView.delegate = self
        sortTableView.dataSource = self
    }
}

extension SortPanModalViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? SortPanModalTableViewCell else {
            return
        }
        cell.backgroundColor = .purpleCategory
        cell.cellLabel.font = UIFont.font(.pretendardSemibold, ofSize: 16)
        cell.cellLabel.textColor = .havitPurple
        filter = cell.contentsSortType?.rawValue
        
        Task {
            do {
                guard let option = option, let filter = filter else {
                    return
                }
                
                if isFromAllCategory {
                    let categoryContents = try await categoryContentsService.getAllContents(option: option,
                                                                                            filter: filter)
                    if let categoryContents = categoryContents,
                       !categoryContents.isEmpty {
                        self.dismiss(animated: true) {
                            self.previousViewController?.categoryContents = categoryContents
                            self.previousViewController?.contentsCollectionView.reloadData()
                            self.previousViewController?.sortButton.setTitle(self.previousViewController?.sortList[indexPath.row], for: .normal)
                            self.previousViewController?.contentsSortType = cell.contentsSortType ?? ContentsSortType.createdAt
                        }
                    } else {
                       // Emtpy 띄우기
                    }
                } else {
                    let categoryContents = try await categoryContentsService.getCategoryContents(categoryID: categoryID, option: option ?? "all", filter: filter ?? "created_At")
                    if let categoryContents = categoryContents,
                       !categoryContents.isEmpty {
                        self.dismiss(animated: true) {
                            self.previousViewController?.categoryContents = categoryContents
                            self.previousViewController?.contentsCollectionView.reloadData()
                            self.previousViewController?.sortButton.setTitle(self.previousViewController?.sortList[indexPath.row], for: .normal)
                            self.previousViewController?.contentsSortType = cell.contentsSortType ?? ContentsSortType.createdAt
                        }
                    } else {
                       // Emtpy 띄우기
                    }
                }
                
            } catch APIServiceError.serverError {
                print("serverError")
            } catch APIServiceError.clientError(let message) {
                print("clientError:\(message)")
            }
        }
    }
}

extension SortPanModalViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withType: SortPanModalTableViewCell.self, for: indexPath)
        cell.cellLabel.text = sortList[indexPath.row]
        cell.selectionStyle = .none
        
        switch indexPath.row {
        case 0:
            contentsSortType = .createdAt
        case 1:
            contentsSortType = .reverse
        case 2:
            contentsSortType = .seenAt
        default:
            print("임시 프린트")
        }
        cell.contentsSortType = contentsSortType
        return cell
    }
}
