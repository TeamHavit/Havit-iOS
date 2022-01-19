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
        return .contentHeight(278)
    }

    var longFormHeight: PanModalHeight {
        return .contentHeight(278)
    }
    
    var cornerRadius: CGFloat {
        return 0
    }
    
    let sortList = ["최신순", "과거순", "최근 조회순"]
    
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
        let cell = tableView.cellForRow(at: indexPath) as! SortPanModalTableViewCell
        cell.backgroundColor = .purpleCategory
        cell.label.font = UIFont.font(.pretendardSemibold, ofSize: 16)
        cell.label.textColor = .havitPurple
    }
}

extension SortPanModalViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withType: SortPanModalTableViewCell.self, for: indexPath)
        cell.label.text = sortList[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}
