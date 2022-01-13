//
//  CategoryViewController.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/06.
//

import UIKit

import SnapKit

class CategoryViewController: UIViewController {

    // MARK: - property
    weak var coordinator: CategoryCoordinator?

    private lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(cell: CategoryCollectionViewCell.self)

        return collectionView
    }()

    private let categoryCountLabel: UILabel = {
        let label = UILabel()
        label.font = .font(FontName.pretendardReular, ofSize: 13)
        label.text = "전체 0"
        label.textColor = UIColor.gray003

        return label
    }()

    // 📌 카테고리 추가 버튼은 재사용될 것 같아서 나중에 따로 빼면 좋을 것 같아요 !
    private let addButton: UIButton = {
        var configuration = UIButton.Configuration.plain()

        var container = AttributeContainer()
        container.font = .font(FontName.pretendardSemibold, ofSize: 12)

        configuration.attributedTitle = AttributedString("카테고리 추가", attributes: container)

        configuration.baseForegroundColor = UIColor.purpleText
        configuration.image = UIImage(named: "category_add")

        configuration.background.cornerRadius = 23
        configuration.background.strokeColor = UIColor.purpleLight
        configuration.background.strokeWidth = 1

        configuration.imagePadding = 2
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 10, bottom: 3, trailing: 10)
        configuration.imagePlacement = .leading

        let button = UIButton(configuration: configuration, primaryAction: nil)

        return button
    }()

    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "iconBackBlack"), for: .normal)
        return button
    }()

    private let editButton: UIButton = {
        let button = UIButton()
        button.setTitle("수정", for: .normal)
        button.titleLabel?.font = .font(FontName.pretendardMedium, ofSize: 14)
        button.setTitleColor(UIColor.gray003, for: .normal)
        return button
    }()

    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegation()
        setLayouts()
        setNavigationBar()
    }

    // MARK: - func
    private func setDelegation() {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
    }

    private func setNavigationBar() {
        title = "전체 카테고리"
        let font = UIFont.font(.pretendardBold, ofSize: 16)
        navigationController?.navigationBar.titleTextAttributes = [.font: font]
        navigationItem.leftBarButtonItem = makeBarButtonItem(with: backButton)
        navigationItem.rightBarButtonItem = makeBarButtonItem(with: editButton)
    }

    private func makeBarButtonItem(with button: UIButton) -> UIBarButtonItem {
        button.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
        button.addTarget(self, action: #selector(buttonDidTapped(_:)), for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }

    @objc
    private func buttonDidTapped(_ sender: UIButton) {
        switch sender {
        case backButton:
            // 뒤로 화면전환 coordinator 선배 써야하는데... 어케 하죵 
            navigationController?.popViewController(animated: true)
        case editButton:
            // 수정 탭으로 넘어가기 일단 임시로 pop 넣어둠
            navigationController?.popViewController(animated: true)
        default:
            break
        }
    }
}

extension CategoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryCollectionView.dequeueReusableCell(forIndexPath: indexPath) as CategoryCollectionViewCell

        return cell
    }
}

extension CategoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 📌 이부분 셀 width 비율에 맞춰서 해주고 싶은데 이 방법밖에 생각이 안나서 더 좋은 방법이 있다면 알려주세요!
        let widthRatio: CGFloat = 343/375
        return CGSize(width: collectionView.frame.width * widthRatio, height: 56)
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

extension CategoryViewController {
    func setLayouts() {
        setViewHierarchies()
        setConstraints()
    }

    func setViewHierarchies() {
        view.addSubview(categoryCollectionView)
        view.addSubview(categoryCountLabel)
        view.addSubview(addButton)
    }

    func setConstraints() {
        categoryCountLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(114)
            $0.leading.equalToSuperview().inset(18)
        }

        addButton.snp.makeConstraints {
            // 네비게이션바에서부터 레이아웃을 잡아야할지 아니면 가장 상단에서 부터 잡아야할지 ! 
            $0.top.equalToSuperview().inset(105)
            $0.leading.equalTo(categoryCountLabel.snp.trailing).offset(195)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(categoryCollectionView.snp.top).offset(-14)
        }

        categoryCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(148)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }
}
