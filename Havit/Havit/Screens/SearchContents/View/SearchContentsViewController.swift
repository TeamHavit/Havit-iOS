//
//  SearchContentsViewController.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/06.
//

import UIKit

import Kingfisher
import SnapKit

final class SearchContentsViewController: BaseViewController {
    
    let searchContentsService: SearchContentsService = SearchContentsService(apiService: APIService(),
                                                                             environment: .development)
    var searchResult: [SearchContents] = []
    
    enum SearchResultType {
        case searching, result, noResult
    }
    
    private var resultType: SearchResultType = .searching
    
    var searchBorderView: CALayer?
    
    private var mainLabel: UILabel = {
        var label = UILabel()
        label.text = "검색된 콘텐츠"
        label.font = UIFont.font(.pretendardReular, ofSize: CGFloat(10))
        label.textColor = .white
        return label
    }()
    
    private var numberLabel: UILabel = {
        var label = UILabel()
        label.text = "3"
        label.font = UIFont.font(.pretendardReular, ofSize: CGFloat(10))
        label.textColor = .white
        return label
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
    
    lazy var resultCollectionView: UICollectionView = {
        var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.backgroundColor = .white
        collectionView.register(cell: NotSearchedCollectionViewCell.self)
        collectionView.register(cell: ContentsCollectionViewCell.self)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegations()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        setFocusSearchBar()
    }
    
    override func viewDidLayoutSubviews() {
       setSearchBarTextField()
    }
    
    func setFocusSearchBar() {
        DispatchQueue.main.async {
            self.searchController.searchBar.becomeFirstResponder()
        }
    }
    
    func setSearchBarTextField() {
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = .clear
            textField.font = UIFont.font(.pretendardMedium, ofSize: CGFloat(14))
            textField.textColor = UIColor.black
            textField.borderStyle = .none
            
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 28, height: textField.frame.size.height))
            textField.rightView = paddingView
            textField.rightViewMode = .always
            
            let clearButton: UIButton = {
                let button = UIButton()
                button.setTitle("취소", for: .normal)
                button.setTitleColor(.black, for: .normal)
                button.titleLabel?.font = UIFont.font(.pretendardMedium, ofSize: CGFloat(14))
                button.addTarget(self, action: #selector(clearClicked(_:)), for: .touchUpInside)
                return button
            }()
            
            paddingView.addSubview(clearButton)
            clearButton.snp.makeConstraints {
                $0.top.bottom.trailing.equalTo(paddingView)
                $0.leading.equalTo(paddingView).offset(paddingView.frame.width)
            }
            
            guard searchBorderView != nil else {
                let border = CALayer()
                border.frame = CGRect(x: 0, y: textField.frame.size.height, width: textField.frame.width - 2 * (paddingView.frame.width), height: 2)
                border.backgroundColor = UIColor.gray001.cgColor
                border.masksToBounds = true
                searchBorderView = border
                textField.layer.addSublayer(searchBorderView!)
                return
            }
        }
    }
    
    override func render() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        view.addSubview(mainView)
        mainView.addSubViews([mainLabel, numberLabel, resultCollectionView])
        
        mainView.snp.makeConstraints {
            $0.leading.top.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        mainLabel.snp.makeConstraints {
            $0.top.equalTo(mainView).offset(25)
            $0.leading.equalTo(mainView).offset(16)
            $0.width.equalTo(55)
            $0.height.equalTo(10)
        }
        
        numberLabel.snp.makeConstraints {
            $0.top.equalTo(mainView).offset(25)
            $0.leading.equalTo(mainLabel).inset(56)
            $0.height.equalTo(10)
        }
        
        resultCollectionView.snp.makeConstraints {
            $0.top.equalTo(mainLabel).offset(19)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)

        }
    }
    
    override func configUI() {
        super.configUI()
        navigationController?.navigationBar.barTintColor = UIColor.whiteGray
        view.backgroundColor = UIColor.whiteGray
    }
    
    private func setDelegations() {
        resultCollectionView.delegate = self
        resultCollectionView.dataSource = self
        searchController.delegate = self
        searchController.searchBar.delegate = self
    }
    
    @objc func clearClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension SearchContentsViewController: UICollectionViewDelegate {
    
}

extension SearchContentsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch resultType {
        case .result:
            return searchResult.count
        case .searching, .noResult:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch resultType {
        case .searching:
            let cell: NotSearchedCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            cell.imageView.image = UIImage(named: "imgSearchIs")
            cell.noResultLabel.isHidden = true
            mainLabel.textColor = .white
            numberLabel.textColor = .white
            return cell
        case .result:
            let cell: ContentsCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            if let searchImageString = searchResult[indexPath.row].image {
                let url = URL(string: searchImageString)
                cell.mainImageView.kf.setImage(with: url)
            }
            cell.titleLabel.text = searchResult[indexPath.row].title
            cell.subtitleLabel.text = searchResult[indexPath.row].datumDescription
            cell.linkLabel.text = searchResult[indexPath.row].url
            cell.dateLabel.text = searchResult[indexPath.row].createdAt
            cell.alarmLabel.text = searchResult[indexPath.row].notificationTime
            if searchResult[indexPath.row].isNotified == true {
                cell.alarmImageView.isHidden = false
            }
            // 읽음 버튼은 머지 후 다음 pr에서 넣기
            
            mainLabel.textColor = .gray003
            numberLabel.textColor = .havitPurple
            return cell
        case .noResult:
            let cell: NotSearchedCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            cell.imageView.image = UIImage(named: "imgSearch")
            cell.noResultLabel.isHidden = false
            mainLabel.textColor = .white
            numberLabel.textColor = .white
            return cell
        }
    }
}

extension SearchContentsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch resultType {
        case .result:
            return CGSize(width: view.frame.width, height: 139)
        case .searching, .noResult:
            return CGSize(width: view.frame.width, height: (mainView.frame.size.height - 15) / 2)
        }
    }
}

extension SearchContentsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        Task {
            do {
                guard let text = searchBar.text else { return }
                let searchResult = try await searchContentsService.getSearchResult(keyword: text)
                if let searchResult = searchResult,
                   !searchResult.isEmpty {
                    self.searchResult = searchResult
                    self.numberLabel.text = "\(searchResult.count)"
                    resultType = .result
                } else {
                    resultType = .noResult
                }
                resultCollectionView.reloadData()
            } catch APIServiceError.serverError {
                print("serverError")
            } catch APIServiceError.clientError(let message) {
                print("clientError:\(message)")
            }
        }
        
    }
}

extension SearchContentsViewController: UISearchControllerDelegate {
    func didPresentSearchController(_ searchController: UISearchController) {
        DispatchQueue.main.async {
            self.searchController.searchBar.becomeFirstResponder()
        }
           
    }
    
}
