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
    var shortFormHeight: PanModalHeight {
        return .contentHeight(300)
    }

    var longFormHeight: PanModalHeight {
        return .contentHeight(300)
    }
    
    // MARK: - Property
    let sortList = ["최신순", "과거순", "최근 조회순"]
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "정렬"
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
        view.addSubview(titleLabel)
        view.addSubview(sortTableView)
        
        titleLabel.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(view)
        }
        
        sortTableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel)
            $0.leading.trailing.equalTo(view)
            $0.height.equalTo(200)
        }
    }
    
    override func configUI() {
        view.backgroundColor = .white
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
}

extension SortPanModalViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withType: SortPanModalTableViewCell.self, for: indexPath)
        cell.label.text = sortList[indexPath.row]
        return cell
    }
}
