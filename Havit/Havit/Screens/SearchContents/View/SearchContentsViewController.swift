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
    
    private var searchController: UISearchController = {
        var searchController = UISearchController()
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.showsCancelButton = false
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
       return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegations()
    }
    
    override func viewDidLayoutSubviews() {
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = .clear
            textField.font = UIFont.font(FontName.pretendardMedium, ofSize: CGFloat(14))
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
                button.titleLabel?.font = UIFont.font(FontName.pretendardMedium, ofSize: CGFloat(14))
                button.addTarget(self, action: #selector(clearClicked(_:)), for: .touchUpInside)
                return button
            }()
         
            paddingView.addSubview(clearButton)
            clearButton.snp.makeConstraints {
                $0.top.bottom.trailing.equalTo(paddingView)
                $0.leading.equalTo(paddingView).offset(paddingView.frame.width)
            }
            
            let border: CALayer = {
                let border = CALayer()
                border.frame = CGRect(x: 0, y: textField.frame.size.height + 36, width: textField.frame.width - 2 * (paddingView.frame.width), height: 2)
                border.backgroundColor = UIColor.gray001.cgColor
                border.masksToBounds = true
                return border
            }()
            
            textField.layer.addSublayer(border)
        }
    }

    override func render() {
        navigationItem.searchController = searchController
        
        view.addSubview(mainView)
        mainView.snp.makeConstraints {
            $0.leading.top.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        mainView.addSubView(resultCollectionView)
        resultCollectionView.snp.makeConstraints {
            $0.top.equalTo(mainView).offset(15)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view)
        }
    }
    
    override func configUI() {
        navigationController?.navigationBar.barTintColor = UIColor.whiteGray
        view.backgroundColor = UIColor.whiteGray
    }
    
    private func setDelegations() {
           resultCollectionView.delegate = self
           resultCollectionView.dataSource = self
       }
    
    @objc func clearClicked(_ sender: UIButton) {

    }
}

extension SearchContentsViewController: UICollectionViewDelegate {
    
}

extension SearchContentsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: NotSearchedCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.imageView.image = UIImage(named: "imgSearch")
        return cell
    }
}

extension SearchContentsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: (mainView.frame.size.height - 15) / 2)
    }
}
