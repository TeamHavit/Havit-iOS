//
//  SelectCategoryViewController.swift
//  ShareExtension
//
//  Created by Noah on 2022/01/20.
//

import UIKit

import RxCocoa
import SnapKit

final class SelectCategoryViewController: BaseViewController {
    
    // MARK: - property
    
    var categories: [Category] = []
    
    var selectedCategoryIds: [Int] = []
    
    var targetContent: TargetContent?
    
    private let navigationLeftButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(image: ImageLiteral.btnBackBlack,
                                            style: .plain,
                                            target: nil,
                                            action: nil)
        barButtonItem.tintColor = .havitGray
        return barButtonItem
    }()
    
    private let navigationRightButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .stop,
                                            target: #selector(dismissButtonDidTap),
                                            action: nil)
        barButtonItem.tintColor = .havitGray
        return barButtonItem
    }()
    
    private let selectCategoryNoticeLabel: UILabel = {
        let label = UILabel()
        label.text = "카테고리를 선택하세요"
        label.font = .font(.pretendardSemibold, ofSize: 22)
        label.textColor = .gray005
        return label
    }()
    
    private let addCategoryButton: UIButton = {
        var configuration = UIButton.Configuration.plain()

        var container = AttributeContainer()
        container.font = .font(.pretendardSemibold, ofSize: 12)

        configuration.attributedTitle = AttributedString("카테고리 추가", attributes: container)
        configuration.baseForegroundColor = UIColor.purpleText
        configuration.image = ImageLiteral.iconCategoryAdd

        configuration.background.cornerRadius = 23
        configuration.background.strokeColor = UIColor.purpleLight
        configuration.background.strokeWidth = 1

        configuration.imagePadding = 2
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 10, bottom: 3, trailing: 10)
        configuration.imagePlacement = .leading

        let button = UIButton(configuration: configuration, primaryAction: nil)
        return button
    }()
    
    private lazy var categoryCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width - 32, height: 56)
        flowLayout.minimumLineSpacing = 8
        flowLayout.minimumInteritemSpacing = 0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = true
        collectionView.isScrollEnabled = true
        collectionView.register(cell: ShareCategoryCollectionViewCell.self)
        return collectionView
    }()
    
    private let completeButton: UIButton = {
        var container = AttributeContainer()
        container.font = .font(.pretendardSemibold, ofSize: 16)
        
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = AttributedString("다음", attributes: container)
        configuration.background.cornerRadius = 0
        configuration.baseForegroundColor = .white
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 173, bottom: 44, trailing: 174)
        
        let button = UIButton(configuration: configuration, primaryAction: nil)
        
        let buttonStateHandler: UIButton.ConfigurationUpdateHandler = { button in
            switch button.state {
            case .normal:
                button.configuration?.background.backgroundColor = .havitPurple
            case .disabled:
                button.configuration?.background.backgroundColor = .gray002
            default:
                return
            }
        }
        button.configurationUpdateHandler = buttonStateHandler
        return button
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegation()
        bind()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - func
    
    override func configUI() {
        setNavigationBar()
        completeButton.isEnabled = false
        view.backgroundColor = .white
    }
    
    override func render() {
        view.addSubViews([selectCategoryNoticeLabel,
                          addCategoryButton,
                          categoryCollectionView,
                          completeButton])
        
        selectCategoryNoticeLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
            $0.leading.equalToSuperview().inset(16)
        }
        
        addCategoryButton.snp.makeConstraints {
            $0.centerY.equalTo(selectCategoryNoticeLabel)
            $0.trailing.equalToSuperview().inset(17)
        }
        
        categoryCollectionView.snp.makeConstraints {
            $0.top.equalTo(selectCategoryNoticeLabel.snp.bottom).offset(34)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(completeButton.snp.top).offset(-10)
        }
        
        completeButton.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(85)
        }
    }
    
    private func setNavigationBar() {
        title = "콘텐츠 저장"
    }
    
    private func setDelegation() {
        categoryCollectionView.delegate = self
    }
    
    private func bind() {
        completeButton.rx.tap
            .bind(onNext: { [weak self] in
                let saveContentsViewController = SaveContentsViewController()
                if let selectedCategoryIds = self?.selectedCategoryIds,
                   let targetContent = self?.targetContent {
                    saveContentsViewController.selectedCategoryIds = selectedCategoryIds
                    saveContentsViewController.targetContent = targetContent
                    self?.navigationController?.pushViewController(saveContentsViewController, animated: true)
                }
            })
            .disposed(by: disposeBag)
        
        addCategoryButton.rx.tap
            .bind(onNext: {
                let addCategoryTitleViewController = AddCategoryTitleViewController(type: .share)
                addCategoryTitleViewController.targetContent = self.targetContent
                self.navigationController?.pushViewController(addCategoryTitleViewController, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - objc
    
    @objc
    private func dismissButtonDidTap() {
        self.extensionContext?.completeRequest(returningItems: nil, completionHandler: nil)
    }
    
    @objc
    private func previousButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SelectCategoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as ShareCategoryCollectionViewCell
        cell.update(data: categories[indexPath.row])
        return cell
    }
}

extension SelectCategoryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ShareCategoryCollectionViewCell {
            cell.didSelect()
            let selectedCategory = categories[indexPath.item]
            let selectedCategoryId = selectedCategory.id
            
            if let selectedCategoryId = selectedCategoryId {
                self.selectedCategoryIds.append(selectedCategoryId)
            }
            
            self.completeButton.isEnabled = true
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ShareCategoryCollectionViewCell {
            cell.didUnSelect()
            let unSelectedCategory = categories[indexPath.item]
            let unSelectedCategoryId = unSelectedCategory.id
            
            if let unselectedCategoryId = unSelectedCategoryId {
                self.selectedCategoryIds = self.selectedCategoryIds.filter {
                    $0 != unselectedCategoryId
                }
            }
            
            if selectedCategoryIds.count == 0 {
                self.completeButton.isEnabled = false
            }
        }
    }
}
