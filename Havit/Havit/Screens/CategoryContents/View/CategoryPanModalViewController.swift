//
//  CategoryPanModealViewController.swift
//  Havit
//
//  Created by 박예빈 on 2022/01/19.
//
import UIKit

import PanModal
import SnapKit

class CategoryPanModalViewController: BaseViewController, PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }
    var shortFormHeight: PanModalHeight = .contentHeight(400)
    var longFormHeight: PanModalHeight = .contentHeight(400)
    var cornerRadius: CGFloat = 0
    
    var previousViewController: CategoryContentsViewController
    
    var categories: [Category]
    var categoryId: Int
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "카테고리명"
        label.font = UIFont.font(.pretendardSemibold, ofSize: 17)
        label.textColor = .primaryBlack
        label.textAlignment = .center
        return label
    }()
    
    let categoryTableView: UITableView = {
        var tableView = UITableView()
        tableView.register(cell: CategoryPanModalTableViewCell.self, forCellReuseIdentifier: CategoryPanModalTableViewCell.className)
        return tableView
    }()
    
    init(previousViewController: CategoryContentsViewController, categoryId: Int, categories: [Category]) {
        self.previousViewController = previousViewController
        self.categoryId = categoryId
        self.categories = categories
        super.init()
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegations()
    }
    
    override func render() {
        view.addSubViews([titleLabel, categoryTableView])
        
        titleLabel.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(view)
            $0.height.equalTo(60)
        }
        
        categoryTableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.trailing.equalTo(view)
            $0.bottom.equalTo(view).inset(74)
        }
    }
    
    override func configUI() {
        view.backgroundColor = .white
        categoryTableView.separatorStyle = .none
    }
    
    private func setDelegations() {
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
    }
    
    private func getNowCategory() -> Category? {
        for i in 0..<categories.count {
            if categories[i].id! == categoryId {
                return categories[i]
            }
        }
        return nil
    }
    
    @objc func showCategoryPanModalViewController(_ sender: UIButton) {
        let viewController = CategoryPanModalViewController(previousViewController: previousViewController, categoryId: categoryId, categories: categories)
        self.presentPanModal(viewController)
    }
}

extension CategoryPanModalViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CategoryPanModalTableViewCell else {
            return
        }
        cell.backgroundColor = .purpleCategory
        cell.cellLabel.font = UIFont.font(.pretendardSemibold, ofSize: 16)
        cell.cellLabel.textColor = .havitPurple
        
        print("클릭된 셀 : \(cell.cellLabel.text), \(cell.tag)")
        
        self.dismiss(animated: true) {
            self.previousViewController.categoryId = cell.tag
            
            var configuration  = UIButton.Configuration.plain()
            configuration.buttonSize = .large
            configuration.imagePlacement = .trailing
            configuration.imagePadding = 3
            configuration.title = "카테고리명"
            configuration.image = ImageLiteral.iconDropBlack
            
            let attributes = AttributeContainer()
            var attributedText = AttributedString.init(cell.cellLabel.text!, attributes: attributes)
            attributedText.font = UIFont.font(.pretendardBold, ofSize: 16)
            attributedText.foregroundColor = .black
            configuration.attributedTitle = attributedText
            
            let button = UIButton(configuration: configuration,
                                  primaryAction: nil)
            button.addTarget(self.previousViewController, action: #selector(self.showCategoryPanModalViewController(_:)), for: .touchUpInside)
            self.previousViewController.navigationItem.titleView = button
            self.previousViewController.getCategoryContents()
            self.previousViewController.contentsCollectionView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension CategoryPanModalViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withType: CategoryPanModalTableViewCell.self, for: indexPath)
        cell.cellLabel.text = categories[indexPath.row].title
        cell.selectionStyle = .none
        
        if let nowCategory = getNowCategory(), let id = nowCategory.id {
            cell.tag = categories[indexPath.row].id!
            if id != categories[indexPath.row].id {
                cell.cellImageView.isHidden = true
            }
        }
        
        return cell
    }
}
