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
    
    private var filterCollectionView: UICollectionView!
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
        
        // 메인 뷰 생성
        mainView = UIView()
        mainView.backgroundColor = .systemRed
        self.view.addSubview(mainView)
        
        // 필터 뷰 생성
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
        
        filterCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        filterCollectionView.backgroundColor = .blue
        filterView.addSubview(filterCollectionView)
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        filterCollectionView.register(CategoryFilterCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: CategoryFilterCollectionViewCell.cellID)
        
        // TODO: 메인 컨텐츠 뷰 생성 - 컬렉션 뷰
        contentsCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        contentsCollectionView.backgroundColor = .green
        mainView.addSubview(contentsCollectionView)
        contentsCollectionView.delegate = self
        contentsCollectionView.dataSource = self
        contentsCollectionView.register(CategoryContentsCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: CategoryContentsCollectionViewCell.cellID)
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
        
        filterCollectionView.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(filterView).offset(0)
            make.bottom.equalTo(filterView).offset(-9)
            make.width.equalTo(250)
            make.height.equalTo(31)
        }
        
        contentsCollectionView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(filterView).offset(0)
            make.leading.equalTo(mainView).offset(0)
            make.trailing.equalTo(mainView).offset(0)
            make.bottom.equalTo(mainView).offset(0)
        }
    }
}


// MARK: - Extensions

extension CategoryContentsViewController: UISearchBarDelegate {
    
}

extension CategoryContentsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case filterCollectionView:
            return 3
        case contentsCollectionView:
            return 1
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case filterCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryFilterCollectionViewCell.cellID, for: indexPath) as! CategoryFilterCollectionViewCell
            cell.filterNameLabel.text = "앙대"
            
            return cell
        case contentsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryContentsCollectionViewCell.cellID, for: indexPath) as! CategoryContentsCollectionViewCell
            
            return cell
        default:
            return UICollectionViewCell()
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case filterCollectionView:
            return CGSize(width: 50, height: 31)
        case contentsCollectionView:
            return CGSize(width: 200, height: 200)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
}
