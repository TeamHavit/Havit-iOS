//
//  CategoryContentsViewController.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/06.
//

import UIKit

import RxSwift
import SnapKit

final class CategoryContentsViewController: BaseViewController {
    enum GridType {
        case grid, grid2xN, grid1xN
    }
    
    // MARK: - Property
    weak var coordinator: CategoryContentsCoordinator?
    
    var gridType: GridType = .grid
    
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
    
    lazy var gridButton: UIButton = {
        let button = UIButton()
        button.setTitle("B", for: .normal)
        button.backgroundColor = UIColor.blue
        button.addTarget(self, action: #selector(changeContentsShow(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var sortButton: UIButton = {
        let button = UIButton()
        button.setTitle("수정", for: .normal)
        button.backgroundColor = UIColor.blue
        button.addTarget(self, action: #selector(showSortBottomSheetViewController(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var navigationRightButton: UIBarButtonItem = {
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
        collectionView.register(cell: CategoryContents2xNCollectionViewCell.self)
        collectionView.register(cell: CategoryContents1xNCollectionViewCell.self)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegations()
    }
    
    override func render() {
        
        // 메인 뷰
        self.view.addSubview(mainView)

        // 필터 뷰
        self.view.addSubview(filterView)
        filterView.addSubview(totalLabel)
        filterView.addSubview(gridButton)
        filterView.addSubview(sortButton)
        
        // 필터 컬렉션 뷰
        filterView.addSubview(filterCollectionView)
        
        // 메인 컨텐츠 뷰 
        mainView.addSubview(contentsCollectionView)
        
        mainView.snp.makeConstraints {
            $0.leading.bottom.trailing.top.equalTo(view.safeAreaLayoutGuide)
        }

        filterView.snp.makeConstraints {
            $0.leading.trailing.equalTo(mainView)
            $0.top.equalTo(mainView).offset(17)
            $0.height.equalTo(67)
        }

        totalLabel.snp.makeConstraints {
            $0.leading.equalTo(filterView).offset(16)
            $0.top.equalTo(filterView)
        }

        gridButton.snp.makeConstraints {
            $0.top.equalTo(filterView)
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
            $0.leading.equalTo(filterView)
            $0.bottom.equalTo(filterView).offset(-9)
            $0.width.equalTo(250)
            $0.height.equalTo(31)
        }

        contentsCollectionView.snp.makeConstraints {
            $0.top.equalTo(filterView).offset(67)
            $0.leading.equalTo(mainView)
            $0.trailing.equalTo(mainView)
            $0.bottom.equalTo(mainView)
        }
    }
    
    override func configUI() {
        super.configUI()
        setNavigationItem()
    }
    
    func setNavigationItem() {
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationItem.rightBarButtonItem = navigationRightButton
        
        navigationItem.searchController = searchController
    }
    
    private func setDelegations() {
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        contentsCollectionView.delegate = self
        contentsCollectionView.dataSource = self
    }
    
    @objc func goToCategoryCorrection(_: UIButton) {
        
    }
    
    @objc func showSortBottomSheetViewController(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: "정렬", message: nil, preferredStyle: .actionSheet)

        actionSheet.addAction(UIAlertAction(title: "최신순", style: .default, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "과거순", style: .default, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "최근 조회순", style: .default, handler: nil))

        // actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet, animated: true, completion: nil)
    }
    
    @objc func showMoreBottomSheetViewController(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: "더보기\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)

           let view = UIView(frame: CGRect(x: 8.0, y: 8.0, width: actionSheet.view.bounds.size.width - 8.0 * 4.5, height: 120.0))
        view.backgroundColor = UIColor.green
        actionSheet.view.addSubview(view)

        actionSheet.addAction(UIAlertAction(title: "제목 수정", style: .default, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "공유", style: .default, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "카테고리 이동", style: .default, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "알림 설정", style: .default, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "삭제", style: .default, handler: nil))
        present(actionSheet, animated: true, completion: nil)
    }
    
    @objc func changeContentsShow(_ sender: UIButton) {
        switch gridType {
        case .grid:
            gridType = .grid2xN
        case .grid2xN:
            gridType = .grid1xN
        case .grid1xN:
            gridType = .grid
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
            switch gridType {
            case .grid:
                let cell: ContentsCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
                cell.backgroundColor = .white
                return cell
            case .grid2xN:
                let cell: CategoryContents2xNCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
                cell.backgroundColor = .white
                return cell
            case .grid1xN:
                let cell: CategoryContents1xNCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
                cell.backgroundColor = .white
                return cell
            }
        default:
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
            switch gridType {
            case .grid:
                return CGSize(width: view.frame.width, height: 139)
            case .grid2xN:
                return CGSize(width: (view.frame.width / 2) - 9, height: 253)
            case .grid1xN:
                return CGSize(width: view.frame.width, height: 290)
            }
        default:
            return CGSize(width: 0, height: 0)
        }
    }
}
