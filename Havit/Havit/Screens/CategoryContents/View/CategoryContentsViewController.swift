//
//  CategoryContentsViewController.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/06.
//

import UIKit

import Kingfisher
import PanModal
import RxSwift
import SnapKit

final class CategoryContentsViewController: BaseViewController {
    
    // MARK: - Property
    let categoryContentsService: CategoryContentsSeriviceable = CategoryContentsService(apiService: APIService(),
                                                                environment: .development)
    var categoryContents: [CategoryContents] = []
    
    var isFromAllCategory: Bool = true
    
    private var gridAnd1XnConstraints: Constraint?
    private var grid2XnConstraints: Constraint?
    
    private var gridType: GridType = .grid
    var contentsSortType: ContentsSortType = .created_at
    var contentsFilterType: ContentsFilterType = .all
    
    var sortList: [String] = ["최신순", "과거순", "최근 조회순"]
    var filterList: [String] = ["전체", "안 봤어요", "봤어요", "알람"]
    
    private let searchBarBorderLayer: CALayer? = CALayer()
    
    private let mainViewBorderView: UIView = {
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
    
    private var mainView: UIView = {
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
        button.setImage(ImageLiteral.iconLayout3, for: .normal)
        button.addTarget(self, action: #selector(changeContentsShow(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var sortButton: UIButton = {
        var configuration  = UIButton.Configuration.plain()
        configuration.buttonSize = .large
        configuration.imagePlacement = .leading
        configuration.imagePadding = 3
        configuration.title = "최근"
        configuration.image = ImageLiteral.iconUpdown
        
        var attributes = AttributeContainer()
        attributes.foregroundColor = .gray003
        var attributedText = AttributedString.init("최신순", attributes: attributes)
        attributedText.font = UIFont.font(.pretendardMedium, ofSize: 12)
        configuration.attributedTitle = attributedText
        
        let button = UIButton(configuration: configuration,
                              primaryAction: nil)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(showSortPanModalViewController(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var navigationTitleButton: UIButton = {
        var configuration  = UIButton.Configuration.plain()
        configuration.buttonSize = .large
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 3
        configuration.title = "카테고리명"
        configuration.image = ImageLiteral.iconDropBlack
        
        var attributes = AttributeContainer()
        attributes.foregroundColor = .primaryBlack
        var attributedText = AttributedString.init("카테고리명", attributes: attributes)
        attributedText.font = UIFont.font(.pretendardBold, ofSize: 16)
        attributedText.foregroundColor = .black
        configuration.attributedTitle = attributedText
        
        let button = UIButton(configuration: configuration,
                              primaryAction: nil)
        button.addTarget(self, action: #selector(showCategoryPanModalViewController(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var navigationRightButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "수정",
                                     style: .plain,
                                     target: self,
                                     action: #selector(goToCategoryCorrection(_:)))
        button.tintColor = .gray003
        let titleAttributes = [
            NSAttributedString.Key.font: UIFont.font(.pretendardMedium, ofSize: CGFloat(14))
            ]
        button.setTitleTextAttributes(titleAttributes, for: .normal)
        self.navigationController?.navigationBar.titleTextAttributes = titleAttributes
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
        getCategoryContents()
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
            $0.width.height.equalTo(18)
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
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        switch gridType {
        case .grid, .grid1xN:
            contentsCollectionView.snp.updateConstraints {
                $0.top.equalTo(mainViewBorderView.snp.bottom)
                $0.leading.trailing.bottom.equalTo(mainView)
            }
        case .grid2xN:
            contentsCollectionView.snp.updateConstraints {
                $0.top.equalTo(mainViewBorderView.snp.bottom)
                $0.leading.equalTo(mainView).offset(13)
                $0.trailing.equalTo(mainView).inset(13)
                $0.bottom.equalTo(mainView)
            }
        }
    }
    
    override func configUI() {
        super.configUI()
        setNavigationItem()
        navigationController?.navigationBar.barTintColor = UIColor.whiteGray
        view.backgroundColor = UIColor.whiteGray
    }
    
    override func viewDidLayoutSubviews() {
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = .clear
            textField.font = UIFont.font(FontName.pretendardMedium, ofSize: CGFloat(14))
            textField.textColor = UIColor.black
            textField.borderStyle = .none
            
            if let border = searchBarBorderLayer {
                border.frame = CGRect(x: 0, y: textField.frame.size.height, width: textField.frame.width, height: 2)
                border.backgroundColor = UIColor.gray001.cgColor
                border.masksToBounds = true
                textField.layer.addSublayer(border)
            }
        }
    }
    
    func getCategoryContents() {
        Task {
            do {
                if isFromAllCategory {
                    let categoryContents = try await categoryContentsService.getAllContents(option: "notified", filter: "created_at")
                    if let categoryContents = categoryContents,
                       !categoryContents.isEmpty {
                        self.categoryContents = categoryContents
                        self.totalLabel.text = "전체 \(categoryContents.count)"
                    } else {
                       // Emtpy 띄우기
                    }
                } else {
                    let categoryContents = try await categoryContentsService.getCategoryContents(categoryID: "3", option: "notified", filter: "created_at")
                    if let categoryContents = categoryContents,
                       !categoryContents.isEmpty {
                        self.categoryContents = categoryContents
                        self.totalLabel.text = "전체 \(categoryContents.count)"
                    } else {
                       // Emtpy 띄우기
                    }
                }
                contentsCollectionView.reloadData()
            } catch APIServiceError.serverError {
                print("serverError")
            } catch APIServiceError.clientError(let message) {
                print("clientError:\(message)")
            }
        }
    }
    
    func setNavigationItem() {
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationItem.rightBarButtonItem = navigationRightButton
        navigationItem.titleView = navigationTitleButton
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
    
    @objc func showSortPanModalViewController(_ sender: UIButton) {
        let viewController = SortPanModalViewController()
        viewController.option = contentsFilterType.rawValue
        viewController.filter = contentsSortType.rawValue
        viewController.previousViewController = self
        self.presentPanModal(viewController)
    }
    
    @objc func showMorePanModalViewController(_ sender: UIButton) {
        let viewController = MorePanModalViewController()
        viewController.contents = categoryContents[sender.tag]
        viewController.previousViewController = self
        self.presentPanModal(viewController)
    }
    
    @objc func showCategoryPanModalViewController(_ sender: UIButton) {
        
        self.presentPanModal(CategoryPanModalViewController())
    }
    
    @objc func changeContentsShow(_ sender: UIButton) {
        switch gridType {
        case .grid:
            gridType = .grid2xN
            contentsCollectionView.backgroundColor = .white
        case .grid2xN:
            gridType = .grid1xN
        case .grid1xN:
            gridType = .grid
            contentsCollectionView.backgroundColor = .whiteGray
        }
        contentsCollectionView.reloadData()
        updateViewConstraints()
    }
}

extension CategoryContentsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case filterCollectionView:
            let cell: CategoryFilterCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            if indexPath.row == FilterType.alarm.rawValue {
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
                cell.layer.cornerRadius = (label.frame.width / 2) * (label.frame.height / label.frame.width) + 10
            }
            cell.layer.masksToBounds = true
            return cell
        case contentsCollectionView:
            switch gridType {
            case .grid:
                let cell: ContentsCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
                let categoryContent = categoryContents[indexPath.row]
                cell.backgroundColor = .white
                gridButton.setImage(ImageLiteral.iconLayout3, for: .normal)
                cell.moreButton.addTarget(self, action: #selector(showMorePanModalViewController(_:)), for: .touchUpInside)
                cell.moreButton.tag = indexPath.row
                if let searchImageString = categoryContents[indexPath.row].image {
                    let url = URL(string: searchImageString)
                    cell.mainImageView.kf.setImage(with: url)
                }
                cell.titleLabel.text = categoryContent.title
                cell.subtitleLabel.text = categoryContent.datumDescription
                cell.linkLabel.text = categoryContent.url
                cell.dateLabel.text = categoryContent.createdAt
                cell.alarmLabel.text = categoryContent.notificationTime
                return cell
            case .grid2xN:
                let cell: CategoryContents2xNCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
                let categoryContent = categoryContents[indexPath.row]
                cell.backgroundColor = .white
                gridButton.setImage(ImageLiteral.iconLayout3, for: .normal)
                cell.moreButton.addTarget(self, action: #selector(showMorePanModalViewController(_:)), for: .touchUpInside)
                cell.moreButton.tag = indexPath.row
                if let searchImageString = categoryContents[indexPath.row].image {
                    let url = URL(string: searchImageString)
                    cell.mainImageView.kf.setImage(with: url)
                }
                cell.titleLabel.text = categoryContent.title
                cell.subtitleLabel.text = categoryContent.datumDescription
                cell.linkLabel.text = categoryContent.url
                cell.dateLabel.text = categoryContent.createdAt
                cell.alarmLabel.text = categoryContent.notificationTime
                return cell
            case .grid1xN:
                let cell: CategoryContents1xNCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
                let categoryContent = categoryContents[indexPath.row]
                cell.backgroundColor = .white
                gridButton.setImage(ImageLiteral.iconLayout3, for: .normal)
                cell.moreButton.addTarget(self, action: #selector(showMorePanModalViewController(_:)), for: .touchUpInside)
                cell.moreButton.tag = indexPath.row
                if let searchImageString = categoryContents[indexPath.row].image {
                    let url = URL(string: searchImageString)
                    cell.mainImageView.kf.setImage(with: url)
                }
                cell.titleLabel.text = categoryContent.title
                cell.subtitleLabel.text = categoryContent.datumDescription
                cell.linkLabel.text = categoryContent.url
                cell.dateLabel.text = categoryContent.createdAt
                cell.alarmLabel.text = categoryContent.notificationTime
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
            return categoryContents.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case filterCollectionView:
            if indexPath.row == FilterType.alarm.rawValue {
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
                return CGSize(width: (view.frame.width / 2) - 20, height: 253)
            case .grid1xN:
                return CGSize(width: view.frame.width, height: 307)
            }
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
