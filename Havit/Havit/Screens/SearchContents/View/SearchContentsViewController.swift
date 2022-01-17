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
        return searchController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

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
                border.frame = CGRect(x: 0, y: textField.frame.size.height-1, width: textField.frame.width - 2 * (paddingView.frame.width), height: 2)
                border.backgroundColor = UIColor.gray001.cgColor
                return border
            }()
            
            textField.layer.addSublayer(border)
        }
    }
    
    @objc func clearClicked(_ sender: UIButton) {

    }

    override func render() {
        navigationItem.searchController = searchController
    }
    
    override func configUI() {
        navigationController?.navigationBar.barTintColor = UIColor.whiteGray
                view.backgroundColor = UIColor.whiteGray
    }
}
