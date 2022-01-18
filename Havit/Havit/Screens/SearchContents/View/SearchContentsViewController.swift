//
//  SearchContentsViewController.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/06.
//

import UIKit

import SnapKit

final class SearchContentsViewController: BaseViewController {
    
    weak var coordinator: SearchContentsCoordinator?
    
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
    
    override func viewDidLayoutSubviews() {
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = .clear
            textField.font = UIFont.font(.pretendardMedium, ofSize: CGFloat(14))
            textField.textColor = UIColor.black
            // textField.tintColor = myTintColor
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
        mainView.snp.makeConstraints {
            $0.leading.top.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        mainView.addSubview(mainLabel)
        mainLabel.snp.makeConstraints {
            $0.top.equalTo(mainView).offset(25)
            $0.leading.equalTo(mainView).offset(16)
            $0.width.equalTo(55)
            $0.height.equalTo(10)
        }
        
        mainView.addSubview(numberLabel)
        numberLabel.snp.makeConstraints {
            $0.top.equalTo(mainView).offset(25)
            $0.leading.equalTo(mainLabel).inset(56)
            $0.height.equalTo(10)
        }
        
        mainView.addSubView(resultCollectionView)
        resultCollectionView.snp.makeConstraints {
            $0.top.equalTo(mainLabel).offset(19)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(mainView)
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
        searchController.searchBar.delegate = self
    }
    
    @objc func clearClicked(_ sender: UIButton) {

    }
}

extension SearchContentsViewController: UICollectionViewDelegate {
    
}

extension SearchContentsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch resultType {
        case .result:
            return 10
        case .searching, .noResult:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch resultType {
        case .result:
            let cell: ContentsCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            mainLabel.textColor = .gray003
            numberLabel.textColor = .havitPurple
            return cell
        case .searching:
            let cell: NotSearchedCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            cell.imageView.image = UIImage(named: "imgSearchIs")
            cell.noResultLabel.isHidden = true
            mainLabel.textColor = .white
            numberLabel.textColor = .white
            return cell
        case .noResult:
            let cell: NotSearchedCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            cell.imageView.image = UIImage(named: "imgSearch")
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
        // 서버 데이터에 따라  검색 결과 없는 경우 분기 처리하기
        resultType = .result
        DispatchQueue.main.async {
            self.resultCollectionView.reloadData()
        }
    }
}
