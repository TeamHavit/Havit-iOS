//
//  CategoryContentsViewController.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/06.
//

import UIKit
import SnapKit
import RxSwift

class CategoryContentsViewController: BaseViewController {
    var searchController: UISearchController!
    var mainView: UIView!
    var filterView: UIView!
    var totalLabel: UILabel!
    var changeShowButton: UIButton!
    var sortButton: UIButton!
    
    private var contentsCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setAutoLayouts()
        
    }
    
    func setUI() {
        // TODO: 네비게이션바 생성 (메인화면에서 Coordinator로 진입)
        
        // 검색바 생성
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "원하는 콘텐츠를 검색하세요."
        self.navigationItem.searchController = searchController
        self.navigationItem.title = "카테고리"
        searchController.hidesNavigationBarDuringPresentation = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        // 메인뷰 생성
        mainView = UIView()
        mainView.backgroundColor = .systemRed
        self.view.addSubview(mainView)
        
        // TODO: 필터뷰 생성 - 전체 레이블, 컬렉션 뷰, 보기 버튼, 정렬 버튼
        filterView = UIView()
        filterView.backgroundColor = .white
        self.view.addSubview(filterView)
        
        totalLabel = {
            let label = UILabel()
            label.text = "전체 0"
            return label
        }()
        filterView.addSubview(totalLabel)
        
        changeShowButton = {
            let button = UIButton()
            button.setTitle("B", for: .normal)
            button.backgroundColor = UIColor.blue
            return button
        }()
        filterView.addSubview(changeShowButton)
        
        sortButton = {
            let button = UIButton()
            button.setTitle("최근순", for: .normal)
            button.backgroundColor = UIColor.blue
            return button
        }()
        filterView.addSubview(sortButton)
        
        
        // TODO: 메인 컨텐츠 뷰 생성 - 컬렉션 뷰
        
    }
    
    func setAutoLayouts() {
        mainView.snp.makeConstraints { (make) -> Void in
            make.leading.bottom.trailing.equalToSuperview()
            make.top.equalTo(view).offset(17)
        }
        
        filterView.snp.makeConstraints { (make) -> Void in
            make.leading.trailing.equalTo(mainView).offset(0)
            make.top.equalTo(mainView).offset(17)
            make.height.equalTo(67)
            
        }
        
        totalLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(filterView).offset(16)
            make.top.equalTo(filterView).offset(0)
        
        }
        
        changeShowButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(filterView).offset(0)
            make.trailing.equalTo(filterView).offset(-16)
            make.width.equalTo(18)
            make.height.equalTo(18)
        }
        
        sortButton.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(filterView).offset(-19)
            make.trailing.equalTo(filterView).offset(-16)
            make.width.equalTo(47)
            make.height.equalTo(15)
        }
    }

}

class CollectionViewCell: UICollectionViewCell {
    
    var memberNameLabel: UILabel!
     
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpCell()
        setUpLabel()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUpCell()
        setUpLabel()
    }
        
    func setUpCell() {
        memberNameLabel = UILabel()
        contentView.addSubview(memberNameLabel)
        memberNameLabel.translatesAutoresizingMaskIntoConstraints = false
        memberNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        memberNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        memberNameLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        memberNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        }
        
    func setUpLabel() {
        memberNameLabel.font = UIFont.systemFont(ofSize: 32)
        memberNameLabel.textAlignment = .center
    }
    
}


// MARK: - Extensions


extension CategoryContentsViewController: UISearchBarDelegate {
    
}
