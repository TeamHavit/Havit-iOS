//
//  MoreBottomSheetViewController.swift
//  Havit
//
//  Created by 박예빈 on 2022/01/15.
//

import UIKit

import SnapKit

class MoreBottomSheetViewController: BaseViewController {

    // MARK: - Property
    let moreList = ["제목 수정", "공유", "카테고리 이동"]
    
    let titleLabel: UILabel  = {
        let label = UILabel()
        label.text = "더보기"
        return label
    }()
    
    let topView: UIView = {
        let view = UIView()
        return view
    }()
    
    let topImageView: UIImageView = UIImageView()
    
    let topTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "헤드라인입니다. 헤드라인입니다."
        return label
    }()
    
    let topDateLabel: UILabel = {
        let label = UILabel()
        label.text = "2021.11.24"
        return label
    }()
    
    let topLinkLabel: UILabel = {
        let label = UILabel()
        label.text = "http://beansbin.oopy.io"
        return label
    }()
    
    let moreTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(cell: MoreBottomSheetTableViewCell.self)
        // sortTableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegations()
    }
    
    override func render() {
        view.addSubViews([titleLabel, topView, moreTableView])
        topView.addSubViews([topImageView, topTitleLabel, topDateLabel, topLinkLabel])
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(view).offset(148)
            $0.top.equalTo(view).offset(80)
        }

        topView.snp.makeConstraints {
            $0.leading.equalTo(view)
            $0.top.equalTo(titleLabel)
            $0.height.equalTo(84)
        }
        
        topImageView.snp.makeConstraints {
            $0.leading.equalTo(view).offset(19)
            $0.top.equalTo(view).offset(13)
            $0.width.equalTo(63)
            $0.height.equalTo(63)
        }
        
        topTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(topImageView).offset(16)
            $0.top.equalTo(titleLabel).offset(14)
            $0.trailing.equalTo(view).inset(36)
        }
        
        topDateLabel.snp.makeConstraints {
            $0.leading.equalTo(topImageView).offset(16)
            $0.top.equalTo(topTitleLabel).offset(3)
        }
        
        topLinkLabel.snp.makeConstraints {
            $0.leading.equalTo(topDateLabel).offset(3)
            $0.top.equalTo(topTitleLabel).offset(3)
            $0.trailing.equalTo(view).inset(36)
        }
        
        moreTableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel)
            $0.leading.trailing.equalTo(view)
            $0.height.equalTo(400)
        }
    }
    
    override func configUI() {
        view.backgroundColor = .white
    }
    
    private func setDelegations() {
        moreTableView.delegate = self
        moreTableView.dataSource = self
    }
}

extension MoreBottomSheetViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moreList.count
    }
}

extension MoreBottomSheetViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withType: MoreBottomSheetTableViewCell.self, for: indexPath)
        cell.label.text = moreList[indexPath.row]
        return cell
    }
}
