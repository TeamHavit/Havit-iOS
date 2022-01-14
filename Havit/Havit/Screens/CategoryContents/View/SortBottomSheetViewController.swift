//
//  SortBottomSheetViewController.swift
//  Havit
//
//  Created by 박예빈 on 2022/01/14.
//

import UIKit

import SnapKit

let sortList = ["최신순", "과거순", "최근 조회순"]

class SortBottomSheetViewController: BaseViewController {
    // MARK: - Property
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "정렬"
        return label
    }()
    
    let sortTableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sortTableView.delegate = self
        sortTableView.dataSource = self
        sortTableView.register(cell: SortBottomSheetTableViewCell.self, forCellReuseIdentifier: SortBottomSheetTableViewCell.className)
        
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
        //sortTableView.separatorStyle = .none
        view.backgroundColor = .white
    }

}

extension SortBottomSheetViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
}

extension SortBottomSheetViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withType: SortBottomSheetTableViewCell.self, for: indexPath)
        cell.label.text = sortList[indexPath.row]
        
        return cell
    }

}

