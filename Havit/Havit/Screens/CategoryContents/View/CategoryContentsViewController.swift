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
    
    var sortList: [String] = ["최신순", "과거순", "최근 조회순"]
    var filterList: [String] = ["전체", "안 봤어요", "봤어요", "알람"]
    
    let searchBarBorderLayer: CALayer? = CALayer()
    
    let mainViewBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray000
        return view
    }()
    
    private var searchController: UISearchController = {
        var searchController = UISearchController()
        searchController.searchBar.showsCancelButton = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "원하는 콘텐츠 검색"
        searchController.searchBar.setImage(UIImage(named: "iconSearch"), for: .search, state: .normal)
        return searchController
    }()
    
    var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
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
        label.font = UIFont.font(FontName.pretendardReular, ofSize: CGFloat(10))
        label.textColor = .black
        return label
    }()
    
    lazy var gridButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "iconLayout3"), for: .normal)
        button.addTarget(self, action: #selector(changeContentsShow(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var sortButton: UIButton = {
        var configuration  = UIButton.Configuration.plain()
        configuration.buttonSize = .large
        configuration.imagePlacement = .leading
        configuration.imagePadding = 3
        configuration.title = "최근"
        configuration.image = UIImage(named: "iconUpdown")
        
        var attributes = AttributeContainer()
        attributes.foregroundColor = .gray003
        var attributedText = AttributedString.init("최근순", attributes: attributes)
        attributedText.font = UIFont.font(FontName.pretendardMedium, ofSize: 12)
        configuration.attributedTitle = attributedText
        
        let button = UIButton(configuration: configuration,
                              primaryAction: nil)
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
        collectionView.register(cell: CategoryFilterCollectionViewCell.self)
        return collectionView
    }()
    
    var contentsCollectionView: UICollectionView = {
        var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.register(cell: ContentsCollectionViewCell.self)
        collectionView.register(cell: CategoryContents2xNCollectionViewCell.self)
        collectionView.register(cell: CategoryContents1xNCollectionViewCell.self)
        collectionView.backgroundColor = .whiteGray
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegations()
    }
    
    override func render() {
        
        self.view.addSubViews([mainView, filterView])
        mainView.addSubViews([mainViewBorderView, contentsCollectionView])
        filterView.addSubViews([totalLabel, gridButton, sortButton, filterCollectionView])
        
        mainView.snp.makeConstraints {
            $0.leading.bottom.trailing.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        filterView.snp.makeConstraints {
            $0.leading.trailing.equalTo(mainView)
            $0.top.equalTo(mainView).offset(17)
            $0.height.equalTo(67)
        }
        
        mainViewBorderView.snp.makeConstraints {
            $0.leading.trailing.equalTo(mainView)
            $0.top.equalTo(filterView.snp.bottom)
            $0.height.equalTo(1)
        }
        
        totalLabel.snp.makeConstraints {
            $0.leading.equalTo(filterView).offset(16)
            $0.top.equalTo(filterView)
        }
        
        gridButton.snp.makeConstraints {
            $0.top.equalTo(filterView)
            $0.trailing.equalTo(filterView).inset(16)
            $0.width.equalTo(18)
            $0.height.equalTo(18)
        }
        
        sortButton.snp.makeConstraints {
            $0.bottom.equalTo(filterView).inset(18)
            $0.trailing.equalTo(filterView).inset(16)
            $0.width.equalTo(50)
            $0.height.equalTo(20)
        }
        
        filterCollectionView.snp.makeConstraints {
            $0.leading.equalTo(filterView).offset(16)
            $0.bottom.equalTo(filterView).inset(9)
            $0.trailing.equalTo(filterView).inset(70)
            $0.height.equalTo(31)
        }
        
        contentsCollectionView.snp.makeConstraints {
            $0.top.equalTo(mainViewBorderView.snp.bottom)
            $0.leading.equalTo(mainView)
            $0.trailing.equalTo(mainView)
            $0.bottom.equalTo(mainView)
        }
    }
    
    override func configUI() {
        super.configUI()
        setNavigationItem()
        navigationController?.navigationBar.barTintColor = UIColor.whiteGray
        view.backgroundColor = UIColor.whiteGray
        
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
    
    override func viewDidLayoutSubviews() {
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = .clear
            textField.font = UIFont.font(FontName.pretendardMedium, ofSize: CGFloat(14))
            textField.textColor = UIColor.black
            // textField.tintColor = myTintColor
            textField.borderStyle = .none
            
            if let border = searchBarBorderLayer {
                border.frame = CGRect(x: 0, y: textField.frame.size.height, width: textField.frame.width, height: 2)
                border.backgroundColor = UIColor.gray001.cgColor
                border.masksToBounds = true
                textField.layer.addSublayer(border)
                
            }
        }
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
            if indexPath.row == 3 {
                cell.filterNameLabel.text = ""
                cell.layer.cornerRadius = 15
            } else {
                cell.filterNameLabel.text = filterList[indexPath.row]
                cell.filterImageView.isHidden = true
                let label: UILabel = {
                    let label = UILabel()
                    label.text = filterList[indexPath.row]
                    label.font = UIFont.font(FontName.pretendardSemibold, ofSize: CGFloat(12))
                    label.sizeToFit()
                    return label
                }()
                cell.layer.cornerRadius = (label.frame.width + 14) / 2
            }
            cell.layer.masksToBounds = true
            return cell
        case contentsCollectionView:
            switch gridType {
            case .grid:
                let cell: ContentsCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
                cell.backgroundColor = .white
                DispatchQueue.main.async {
                    self.gridButton.setImage(UIImage(named: "iconLayout3"), for: .normal)
                }
                return cell
            case .grid2xN:
                let cell: CategoryContents2xNCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
                cell.backgroundColor = .white
                DispatchQueue.main.async {
                    self.gridButton.setImage(UIImage(named: "iconLayout4"), for: .normal)
                }
                return cell
            case .grid1xN:
                let cell: CategoryContents1xNCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
                cell.backgroundColor = .white
                DispatchQueue.main.async {
                    self.gridButton.setImage(UIImage(named: "iconLayout2"), for: .normal)
                    // self.sortButton.setTitle(self.sortList[2], for: .normal)
                }
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
            return 4
        case contentsCollectionView:
            return 10
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case filterCollectionView:
            if indexPath.row == 3 {
                return CGSize(width: 46, height: 31)
            } else {
                let label: UILabel = {
                    let label = UILabel()
                    label.text = filterList[indexPath.row]
                    label.font = UIFont.font(FontName.pretendardSemibold, ofSize: CGFloat(12))
                    label.sizeToFit()
                    return label
                }()
                return CGSize(width: label.frame.width + 28, height: 31)
            }
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

//// ViewController의 Preview
// #if canImport(SwiftUI) && DEBUG
// import SwiftUI
//
// struct Preview: PreviewProvider {
//    static var previews: some View {
//        CategoryContentsViewController().showPreview(.iPhone13Mini)
//        CategoryContentsViewController().showPreview(.iPhone12ProMax)
//    }
// }
// #endif

//// View의 Preview
// #if canImport(SwiftUI) && DEBUG
// import SwiftUI
//
// struct Preview: PreviewProvider {
//    static var previews: some View {
//        CategoryContentsViewController().showPreview(.iPhone13Mini)
//        CategoryContentsViewController().showPreview(.iPhoneSE2)
//    }
// }
// #endif

//// View의 Preview
// #if canImport(SwiftUI) && DEBUG
// import SwiftUI
//
// struct Preview: PreviewProvider {
//    static var previews: some View {
//        CategoryFilterCollectionViewCell.showPreview(.iPhone13Mini)
//        CategoryFilterCollectionViewCell.showPreview(.iPhoneSE2)
//    }
// }
// #endif
