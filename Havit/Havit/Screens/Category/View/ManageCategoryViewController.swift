//
//  ManageCategoryViewController.swift
//  Havit
//
//  Created by 김수연 on 2022/01/14.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

class ManageCategoryViewController: BaseViewController {

    // MARK: - property

    let categoryService: CategorySeriviceable = CategoryService(apiService: APIService(), environment: .development)

    var categories: [Category] = []
    var categoryIndexArray: [Int] = []
    let categoryIconList: [CategoryIconList] = CategoryIconList.iconList

    private lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(cell: CategoryCollectionViewCell.self)
        return collectionView
    }()

    private let backButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
        button.setImage(ImageLiteral.iconBackWhite, for: .normal)
        return button
    }()

    private let doneButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
        button.setTitle("완료", for: .normal)
        button.titleLabel?.font = .font(.pretendardMedium, ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    private let noticeIcon: UIImageView = {
        let image = UIImageView()
        image.image = ImageLiteral.iconNoticeGray
        return image
    }()

    private let noticeLabel: UILabel = {
        let label = UILabel()
        label.text = "카테고리를 누른 뒤 위아래로 드래그하여 순서를 바꿀 수 있습니다"
        label.font = .font(.pretendardReular, ofSize: 12)
        label.textColor = .gray002
        return label
    }()

    // MARK: - init

    override init() {
        super.init()
        self.hidesBottomBarWhenPushed = true
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegation()
        setGesture()
    }

    func changeOrderCategory() {
        Task {
            do {
                updateCategoryIndexArray()
                print(categoryIndexArray)
                try await categoryService.changeCategoryOrder(categoryIndexArray: categoryIndexArray)
            } catch APIServiceError.serverError {
                print("serverError")
            } catch APIServiceError.clientError(let message) {
                print("clientError:\(String(describing: message))")
            }
        }
    }

    override func render() {
        view.addSubViews([categoryCollectionView, noticeIcon, noticeLabel])

        noticeIcon.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(29)
            $0.leading.equalToSuperview().inset(26)
            $0.bottom.equalTo(categoryCollectionView.snp.top).inset(-15)
            $0.width.height.equalTo(12)
        }

        noticeLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(26)
            $0.leading.equalTo(noticeIcon.snp.trailing).offset(5)
            $0.bottom.equalTo(categoryCollectionView.snp.top).inset(-13)
        }

        categoryCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(56)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }

    override func configUI() {
        view.backgroundColor = .white
        setupBaseNavigationBar(backgroundColor: .havitPurple, titleColor: .white, isTranslucent: false, tintColor: .white)
        setNavigationItem()
        bind()
    }

    // MARK: - func

    private func setDelegation() {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
    }

    private func setNavigationItem() {
        title = "카테고리 수정"
        let appearance = UINavigationBarAppearance()

        appearance.titleTextAttributes = [
            .font: UIFont.font(.pretendardBold, ofSize: 16)
        ]

        navigationItem.leftBarButtonItem = makeBarButtonItem(with: backButton)
        navigationItem.rightBarButtonItem = makeBarButtonItem(with: doneButton)
    }

    private func makeBarButtonItem(with button: UIButton) -> UIBarButtonItem {
        return UIBarButtonItem(customView: button)
    }

    private func bind() {
        backButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)

        doneButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.changeOrderCategory()
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }

    private func setGesture() {
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(_:)))
        categoryCollectionView.addGestureRecognizer(longPressRecognizer)
    }

    @objc
    private func handleLongPressGesture(_ gesture: UILongPressGestureRecognizer) {
        let startIndexPath = categoryCollectionView.indexPathForItem(at: gesture.location(in: categoryCollectionView))
        let cell = cellForItemAt(at: startIndexPath)
        switch gesture.state {
        case .began:
            guard let startIndexPath = startIndexPath else {
                break
            }
            cell?.backgroundColor = .purple002
            categoryCollectionView.beginInteractiveMovementForItem(at: startIndexPath)
        case .changed:
            categoryCollectionView.updateInteractiveMovementTargetPosition(gesture.location(in: categoryCollectionView))
        case .ended:
            cell?.backgroundColor = .purpleCategory
            categoryCollectionView.endInteractiveMovement()
        default:
            cell?.backgroundColor = .purpleCategory
            categoryCollectionView.cancelInteractiveMovement()
        }
    }

    private func cellForItemAt(at indexPath: IndexPath?) -> UICollectionViewCell? {
        guard let indexPath = indexPath else {
            return nil
        }
        return categoryCollectionView.cellForItem(at: indexPath)
    }

    func updateCategoryIndexArray() {
        (0..<categories.count).forEach {
            categoryIndexArray.append(categories[$0].id ?? 0)
        }
    }
}

extension ManageCategoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as CategoryCollectionViewCell
        
        cell.configure(type: .manage)
        cell.update(data: categories[indexPath.row])
        cell.presentEditCategoryClosure = {
            let categoryId = self.categories[indexPath.row].id ?? 0
            let titleText = self.categories[indexPath.row].title ?? ""
            var imageId = self.categories[indexPath.row].imageId ?? 0
            
            let editCategory = EditCategoryViewController(categoryId: categoryId, titleText: titleText, imageId: imageId)
            let compareId = (categoryId == editCategory.categoryId)
            
            editCategory.sendEditData = {
                if compareId {
                    if let index = self.categories[indexPath.row].orderIndex {
                        self.categories[index].title = editCategory.titleText
                    }
                    imageId = editCategory.iconImageId
                    cell.categoryImageView.image = self.categoryIconList[imageId].categoryIcon
                    collectionView.reloadData()
                }
            }
            
            editCategory.sendDeleteData = {
                if compareId {
                    if let index = self.categories[indexPath.row].orderIndex {
                        self.categories.remove(at: index)
                    }
                    collectionView.reloadData()
                }
            }

            self.navigationController?.pushViewController(editCategory, animated: true)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }

     // move를 시작한 인덱스에 해당하는 아이템을 기존 List에서 제거하고 categooryItem 에 저장
     // move를 해서 도착한 인덱스에 해당하는 아이템을 기존 List에 추가
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let cell = categoryCollectionView.cellForItem(at: destinationIndexPath)
        cell?.backgroundColor = .purpleCategory

        let categoryItem = categories.remove(at: sourceIndexPath.row)
        categories.insert(categoryItem, at: destinationIndexPath.row)
    }
}

extension ManageCategoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width - 32, height: 56)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
