//
//  SelectCategoryIconViewController.swift
//  ShareExtension
//
//  Created by Noah on 2022/01/20.
//

import UIKit

import SnapKit

final class SelectCategoryIconViewController: BaseViewController {
    
    // MARK: - property
    
    let categoryIconList: [CategoryIconList] = CategoryIconList.iconList
    
    let categoryService: CategorySeriviceable = CategoryService(apiService: APIService(), environment: .development)
    
    var categories: [Category] = []
    
    var targetContent: TargetContent?
    
    var userRequestCategory: RequestCategory?
    
    var categoryEntryPoint: CategoryEntryPointType?
    
    var selectedCategoryImageId: Int = 1
    
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
                                            target: nil,
                                            action: nil)
        barButtonItem.tintColor = .havitGray
        return barButtonItem
    }()
    
    private let selectIconNoticeLabel: UILabel = {
        let label = UILabel()
        label.text = "아이콘을 선택하세요"
        label.font = .font(.pretendardSemibold, ofSize: 22)
        label.textColor = .gray005
        return label
    }()
    
    private let selectIconHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "아이콘"
        label.font = .font(.pretendardSemibold, ofSize: 14)
        label.textColor = .havitPurple
        return label
    }()
    
    private lazy var iconCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.itemSize = CGSize(width: 62, height: 62)
        flowLayout.minimumLineSpacing = 7
        flowLayout.minimumInteritemSpacing = 7
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.register(cell: CategoryIconCollectionViewCell.self)
        return collectionView
    }()
    
    private let completeButton: UIButton = {
        var container = AttributeContainer()
        container.font = .font(.pretendardSemibold, ofSize: 16)
        
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = AttributedString("완료", attributes: container)
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
    
    // MARK: - func
    
    override func configUI() {
        setNavigationBar()
        view.backgroundColor = .white
        completeButton.isEnabled = false
    }
    
    override func render() {
        view.addSubViews([selectIconNoticeLabel,
                          selectIconHeaderLabel,
                          iconCollectionView,
                          completeButton])
        
        selectIconNoticeLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(40)
            $0.leading.equalToSuperview().inset(16)
        }
        
        selectIconHeaderLabel.snp.makeConstraints {
            $0.top.equalTo(selectIconNoticeLabel.snp.bottom).offset(34)
            $0.leading.equalTo(selectIconNoticeLabel)
        }
        
        iconCollectionView.snp.makeConstraints {
            $0.top.equalTo(selectIconHeaderLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
        
        completeButton.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(84)
        }
    }
    
    private func setNavigationBar() {
        title = "카테고리 추가"
        navigationItem.leftBarButtonItem = navigationLeftButton
        navigationItem.rightBarButtonItem = navigationRightButton
    }
    
    private func setDelegation() {
        iconCollectionView.delegate = self
    }
    
    private func bind() {
        iconCollectionView.rx.itemSelected
            .bind(onNext: { [weak self] _ in
                if let selectedCategoryImageId = self?.selectedCategoryImageId {
                    self?.completeButton.isEnabled = (selectedCategoryImageId > 1)
                }
            })
            .disposed(by: disposeBag)
        
        completeButton.rx.tap
            .bind(onNext: { [weak self] _ in
                switch self?.categoryEntryPoint {
                case .share:
                    self?.createCategory {
                        self?.getCategory()
                    }
                case .category:
                    self?.createCategory {
                        self?.dismiss(animated: true, completion: nil)
                    }
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func createCategory(completionHandler: @escaping () -> Void) {
        Task {
            do {
                if let requestCategoryTitle = userRequestCategory?.title,
                   let requestImageId = userRequestCategory?.imageId {
                    _ = try await categoryService.createCategory(title: requestCategoryTitle,
                                                             imageId: requestImageId)
                }
                completionHandler()
            } catch APIServiceError.serverError {
                Logger.debugDescription("serverError")
            } catch APIServiceError.clientError(let message) {
                Logger.debugDescription("clientError:\(String(describing: message))")
            }
        }
    }
    
    private func getCategory() {
        Task {
            do {
                async let responseCategories = try await categoryService.getCategory()
                if let categories = try await responseCategories {
                    self.categories = categories
                }
                pushNextViewController()
            } catch APIServiceError.serverError {
                Logger.debugDescription("serverError")
            } catch APIServiceError.clientError(let message) {
                Logger.debugDescription("clientError:\(String(describing: message))")
            }
        }
    }
    
    private func pushNextViewController() {
        let selectCategoryViewController = SelectCategoryViewController()
        selectCategoryViewController.targetContent = self.targetContent
        selectCategoryViewController.categories = self.categories
        self.navigationController?.pushViewController(selectCategoryViewController, animated: true)
    }
}

extension SelectCategoryIconViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as CategoryIconCollectionViewCell
        cell.update(data: categoryIconList[indexPath.row])
        return cell
    }
}

extension SelectCategoryIconViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedIconIndex = indexPath.row
        selectedCategoryImageId = selectedIconIndex + 1
        userRequestCategory?.imageId = selectedCategoryImageId
    }
}
