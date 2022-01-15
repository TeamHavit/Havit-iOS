//
//  CategoryContentsViewController.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/06.
//

import UIKit

import BTNavigationDropdownMenu
import MaterialComponents.MaterialBottomSheet
import RxSwift
import SnapKit

final class CategoryContentsViewController: BaseViewController {
    enum ShowSort: String {
        case Sort1, Sort2, Sort3
    }
    
    // MARK: - Property
    weak var coordinator: CategoryContentsCoordinator?
    
    var sortNum: ShowSort = ShowSort.Sort1
    
    var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "원하는 콘텐츠를 검색하세요."
        searchController.hidesNavigationBarDuringPresentation = false
        return searchController
    }()
    
    var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemCyan
        return view
    }()
    
    var filterView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    var totalLabel: UILabel = {
        let label = UILabel()
        label.text = "전체 0"
        return label
    }()
    
    var changeShowButton: UIButton = {
        let button = UIButton()
        button.setTitle("B", for: .normal)
        button.backgroundColor = UIColor.blue
        button.addTarget(self, action: #selector(changeContentsShow(_:)), for: .touchUpInside)
        return button
    }()
    
    var sortButton: UIButton = {
        let button = UIButton()
        button.setTitle("수정", for: .normal)
        button.backgroundColor = UIColor.blue
        button.addTarget(self, action: #selector(showSortBottomSheet(_:)), for: .touchUpInside)
        return button
    }()
    
    var navigationRightButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "수정",
                                     style: .plain,
                                     target: self,
                                     action: #selector(goToCategoryCorrection(_:)))
        return button
    }()
    
    var filterCollectionView: UICollectionView = {
        var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.backgroundColor = .blue
        collectionView.register(cell: CategoryFilterCollectionViewCell.self)
        return collectionView
    }()
    
    var contentsCollectionView: UICollectionView = {
        var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.backgroundColor = .green
        collectionView.register(cell: ContentsCollectionViewCell.self)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func render() {
        
        // 메인 뷰
        self.view.addSubview(mainView)

        // 필터 뷰
        self.view.addSubview(filterView)
        filterView.addSubview(totalLabel)
        filterView.addSubview(changeShowButton)
        filterView.addSubview(sortButton)
        
        // 필터 컬렉션 뷰
        filterView.addSubview(filterCollectionView)
        
        // 메인 컨텐츠 뷰 
        mainView.addSubview(contentsCollectionView)
        
        mainView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }

        filterView.snp.makeConstraints {
            $0.leading.trailing.equalTo(mainView).offset(0)
            $0.top.equalTo(mainView).offset(17)
            $0.height.equalTo(67)
        }

        totalLabel.snp.makeConstraints {
            $0.leading.equalTo(filterView).offset(16)
            $0.top.equalTo(filterView).offset(0)
        }

        changeShowButton.snp.makeConstraints {
            $0.top.equalTo(filterView).offset(0)
            $0.trailing.equalTo(filterView).offset(-16)
            $0.width.equalTo(18)
            $0.height.equalTo(18)
        }

        sortButton.snp.makeConstraints {
            $0.bottom.equalTo(filterView).offset(-19)
            $0.trailing.equalTo(filterView).offset(-16)
            $0.width.equalTo(47)
            $0.height.equalTo(15)
        }

        filterCollectionView.snp.makeConstraints {
            $0.leading.equalTo(filterView).offset(0)
            $0.bottom.equalTo(filterView).offset(-9)
            $0.width.equalTo(250)
            $0.height.equalTo(31)
        }

        contentsCollectionView.snp.makeConstraints {
            $0.top.equalTo(filterView).offset(67)
            $0.leading.equalTo(mainView).offset(0)
            $0.trailing.equalTo(mainView).offset(0)
            $0.bottom.equalTo(mainView).offset(0)
        }
    }
    
    override func configUI() {
        setNavigationItems()
    }
    
    func setNavigationItems() {
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = true
        
        self.navigationItem.rightBarButtonItem = navigationRightButton
        
        navigationItem.searchController = searchController
        let items = ["Most Popular", "Latest", "Trending", "Nearest", "Top Picks"]
        let menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, viewController: self, containerView: self.navigationController!.view, title: BTTitle.title("카테고리"), items: items)
        navigationItem.titleView = menuView
    }
    
    func setDelegations() {
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        contentsCollectionView.delegate = self
        contentsCollectionView.dataSource = self
    }
    
    @objc func goToCategoryCorrection(_: UIButton) {
        
    }
    
    @objc func showSortBottomSheet(_ sender: UIButton) {
        let vc = SortBottomSheetViewController()
        let bottomSheet: MDCBottomSheetController = MDCBottomSheetController(contentViewController: vc)
        present(bottomSheet, animated: true, completion: nil)
    }
    
    @objc func changeContentsShow(_ sender: UIButton) {
        print("change!")
        switch sortNum {
        case .Sort1:
            sortNum = .Sort2
            contentsCollectionView.register(cell: SortTwoContentsCollectionViewCell.self)
        case .Sort2:
            sortNum = .Sort3
            contentsCollectionView.register(cell: SortThreeContentsCollectionViewCell.self)
        case .Sort3:
            sortNum = .Sort1
            contentsCollectionView.register(cell: ContentsCollectionViewCell.self)
        }
        contentsCollectionView.reloadData()
    }
}

extension CategoryContentsViewController: UISearchBarDelegate {
    
}

extension CategoryContentsViewController: UICollectionViewDelegate {
    
}

extension CategoryContentsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case filterCollectionView:
            let cell: CategoryFilterCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            cell.filterNameLabel.text = "앙대"
            
            return cell
        case contentsCollectionView:
            switch sortNum {
            case .Sort1:
                let cell: ContentsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentsCollectionViewCell.className, for: indexPath) as! ContentsCollectionViewCell
                cell.backgroundColor = .white
                return cell
            case .Sort2:
                let cell: SortTwoContentsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: SortTwoContentsCollectionViewCell.className, for: indexPath) as! SortTwoContentsCollectionViewCell
                cell.backgroundColor = .white
                return cell
            case .Sort3:
                let cell: SortThreeContentsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: SortThreeContentsCollectionViewCell.className, for: indexPath) as! SortThreeContentsCollectionViewCell
                cell.backgroundColor = .white
                return cell
            }
        default:
            print("?????????")
            return UICollectionViewCell()
        }
    }
}

extension CategoryContentsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case filterCollectionView:
            return 3
        case contentsCollectionView:
            return 10
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case filterCollectionView:
            return CGSize(width: 50, height: 31)
        case contentsCollectionView:
            if sortNum == .Sort1 {
                return CGSize(width: view.frame.width, height: 139)
            } else if sortNum == .Sort2 {
                return CGSize(width: (view.frame.width / 2) - 9, height:253)
            } else {
                return CGSize(width: view.frame.width, height: 290)
            }
        default:
            return CGSize(width: 0, height: 0)
        }
    }
}
