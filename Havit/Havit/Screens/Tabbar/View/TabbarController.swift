//
//  TabbarController.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/06.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

class TabbarController: UITabBarController {
    
    enum Size {
        static let screenWidth = UIScreen.main.bounds.width
        static let addButtonSize = CGSize(width: 52,
                                          height: 52)
        static let addButtonTrailing: CGFloat = 20
        static let addButtonRadius: CGFloat = addButtonSize.width / 2
        static let addButtonCenterX = screenWidth - addButtonTrailing - addButtonRadius
    }
    
    typealias TabMetaData = (viewController: UIViewController,
                                unselecedImage: UIImage,
                                selectedImage: UIImage)
    
    // MARK: - property
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(ImageLiteral.btnAdd, for: .normal)
        button.applyZeplinShadow(color: .black,
                                 alpha: 0.25,
                                 x: 0,
                                 y: 4,
                                 blur: 4,
                                 spread: 0)
        return button
    }()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        render()
        configure()
        bind()
    }
    
    // MARK: - func
    
    private func render() {
        self.tabBar.addSubview(addButton)
        self.addButton.snp.makeConstraints {
            $0.centerX.equalTo(Size.addButtonCenterX)
            $0.centerY.equalTo(tabBar.snp.top)
        }
    }
    
    private func configure() {
        setTabBar()
        setTabBarViewControllers()
    }
    
    private func setTabBar() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = .black
        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
        tabBar.tintColor = .white
    }
    
    private func setTabBarViewControllers() {
        
        let mainTabMetaData = (viewController: CategoryContentsViewController(),
                               unselecedImage: ImageLiteral.iconHomeUnselected,
                               selectedImage: ImageLiteral.iconHomeSelected)
        let categoryTabMetaData = (viewController: CategoryViewController(type: .tabbar),
                                   unselecedImage: ImageLiteral.iconCategoryUnselected,
                                   selectedImage: ImageLiteral.iconCategoryUnselected)
        let myPageTabMetaData = (viewController: UIViewController(),
                                 unselecedImage: ImageLiteral.iconMypageUnselected,
                                 selectedImage: ImageLiteral.iconMypageSelected)
        
        let tabBarViewControllers: [UIViewController] = {
            let tabBarViewControllers = [mainTabMetaData,
                                         categoryTabMetaData,
                                         myPageTabMetaData]
                .map(setTabBarItem)
                .map(wrapInNavigationController)
            return appendUserDisabledTab(to: tabBarViewControllers)
        }()
        
        setViewControllers(tabBarViewControllers, animated: true)
    }
    
    private func appendUserDisabledTab(to viewControllers: [UIViewController]) -> [UIViewController] {
        let emptyViewController: UIViewController = {
            let viewController = UIViewController()
            viewController.view.backgroundColor = .primaryBlack
            viewController.tabBarItem.isEnabled = false
            return viewController
        }()
        var viewControllers = viewControllers
        viewControllers.append(emptyViewController)
        return viewControllers
    }
    
    private func setTabBarItem(for viewController: UIViewController,
                               unselecedImage: UIImage?,
                               selectedImage: UIImage?) -> UIViewController {
        viewController.tabBarItem = UITabBarItem(title: nil, image: unselecedImage, selectedImage: selectedImage)
        viewController.tabBarItem.imageInsets = UIEdgeInsets.init(top: 5, left: 0, bottom: -5, right: 0)
        return viewController
    }
    
    private func wrapInNavigationController(viewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
    
    private func bind() {
        let dummy: UIViewController = {
            let dummy = UIViewController()
            dummy.view.backgroundColor = .blue
            return dummy
        }()
        let dummyInNavigation = wrapInNavigationController(viewController: dummy)
        
        addButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.present(dummyInNavigation, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
}
