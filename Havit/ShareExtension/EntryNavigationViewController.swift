//
//  EntryNavigationViewController.swift
//  ShareExtension
//
//  Created by Noah on 2022/01/14.
//

import UIKit

@objc(EntryNavigationViewController)
final class EntryNavigationViewController: UINavigationController {
    
    let categoryService: CategorySeriviceable = CategoryService(apiService: APIService(), environment: .development)
    
    var categories: [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCategory()
        configUI()
    }
    
    private func configUI() {
        view.backgroundColor = .white
        setupBaseNavigationBar()
    }
    
    private func getCategory() {
        Task {
            do {
                let categories = try await categoryService.getCategory()
                if let categories = categories, !categories.isEmpty {
                    self.categories = categories
                } else {
                    self.categories = []
                }
                branchCategoryNavigate()
            } catch APIServiceError.serverError {
                Logger.debugDescription("serverError")
            } catch APIServiceError.clientError(let message) {
                if let message = message {
                    Logger.debugDescription("clientError:\(message)")
                }
            }
        }
    }
    
    private func branchCategoryNavigate() {
        if categories.isEmpty {
            let categoryEmptyViewController = CategoryEmptyViewController()
            self.pushViewController(categoryEmptyViewController, animated: true)
        } else {
            let selectCategoryViewControllr = SelectCategoryViewController()
            selectCategoryViewControllr.categories = self.categories
            self.pushViewController(selectCategoryViewControllr, animated: true)
        }
    }
    
    func setupBaseNavigationBar() {
        let appearance = UINavigationBarAppearance()
        let font = UIFont.font(.pretendardBold, ofSize: 16)
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.havitGray, .font: font]
        appearance.shadowColor = .clear
        
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.isTranslucent = false
    }
}
