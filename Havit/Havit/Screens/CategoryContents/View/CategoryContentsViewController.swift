//
//  CategoryContentsViewController.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/06.
//

import UIKit

class CategoryContentsViewController: BaseViewController {
    var searchController: UISearchController!

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
        
        // TODO: 필터뷰 생성 - 컬렉션 뷰, 보기 버튼, 정렬 버튼
        
        
        
        // TODO: 메인뷰 생성 - 컬렉션 뷰
        
    }
    
    func setAutoLayouts() {

    }
    


}

extension CategoryContentsViewController: UISearchBarDelegate {
    
}
