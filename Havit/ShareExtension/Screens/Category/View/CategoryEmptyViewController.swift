//
//  CategoryEmptyViewController.swift
//  ShareExtension
//
//  Created by Noah on 2022/01/16.
//

import UIKit

import SnapKit

final class CategoryEmptyViewController: BaseViewController {
    
    // MARK: - property
    
    var targetContent: TargetContent?
    
    private let navigationTitleTextAttributes = [
        NSAttributedString.Key.foregroundColor: UIColor.havitGray,
        NSAttributedString.Key.font: UIFont.font(.pretendardBold, ofSize: 16)
    ]
    
    private let navigationRightButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .stop,
                                            target: nil,
                                            action: nil)
        barButtonItem.tintColor = .havitGray
        
        return barButtonItem
    }()
    
    private let categoryEmptyNoticeLabel: UILabel = {
        let label = UILabel()
        label.text = "카테고리가 아직 없어요"
        label.font = .font(.pretendardSemibold, ofSize: 22)
        label.textColor = .gray005
        
        return label
    }()
    
    private let categoryEmptyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiteral.imgGraphicNocategory
        
        return imageView
    }()
    
    private let addCategoryButton: UIButton = {
        var container = AttributeContainer()
        container.font = .font(.pretendardMedium, ofSize: 15)
        
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = AttributedString("카테고리 추가", attributes: container)
        configuration.baseForegroundColor = .white
        configuration.background.backgroundColor = .havitPurple
        configuration.background.cornerRadius = 44
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 14, leading: 17, bottom: 17, trailing: 14)
        
        let button = UIButton(configuration: configuration)
        
        return button
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    // MARK: - func
    
    override func configUI() {
        setNavigationBar()
    }
    
    override func render() {
        view.addSubViews([categoryEmptyNoticeLabel, categoryEmptyImageView, addCategoryButton])
        
        categoryEmptyNoticeLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
            $0.leading.equalToSuperview().inset(16)
        }
        
        categoryEmptyImageView.snp.makeConstraints {
            $0.top.equalTo(categoryEmptyNoticeLabel).offset(125)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(203)
            $0.height.equalTo(246)
        }
        
        addCategoryButton.snp.makeConstraints {
            $0.top.equalTo(categoryEmptyImageView.snp.bottom).offset(101).priority(.low)
            $0.leading.trailing.equalToSuperview().inset(71)
            $0.bottom.lessThanOrEqualTo(view.snp.bottom).inset(50)
        }
    }
    
    private func setNavigationBar() {
        title = "카테고리 추가"
        navigationController?.navigationBar.titleTextAttributes = navigationTitleTextAttributes
        navigationItem.rightBarButtonItem = navigationRightButton
    }
    
    private func bind() {
        addCategoryButton.rx.tap
            .bind(onNext: {
                let addCategoryTitleViewController = AddCategoryTitleViewController(type: .category)
                addCategoryTitleViewController.targetContent = self.targetContent
                self.navigationController?.pushViewController(addCategoryTitleViewController, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
