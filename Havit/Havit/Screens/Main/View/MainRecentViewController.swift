//
//  MainRecentViewController.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/20.
//

import UIKit

import SnapKit

final class MainRecentViewController: BaseViewController {
    
    private enum Size {
        static let cellWidth: CGFloat = UIScreen.main.bounds.size.width
        static let cellHeight: CGFloat = 139
    }
    
    // MARK: - property
    
    private let backButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
        button.setImage(ImageLiteral.btnBackBlack, for: .normal)
        return button
    }()
    private lazy var contentCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: Size.cellWidth, height: Size.cellHeight)
        flowLayout.minimumLineSpacing = 1
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .gray000
        collectionView.dataSource = self
        collectionView.register(cell: ContentsCollectionViewCell.self)
        return collectionView
    }()
    private let recentEmptyView = MainContentEmptyView(guideText:
                                                            "최근에 저장한 콘텐츠가 없습니다.\n새로운 콘텐츠를 저장해 보세요!")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func render() {
        view.addSubView(recentEmptyView)
        recentEmptyView.addSubview(contentCollectionView)
        
        recentEmptyView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        contentCollectionView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func configUI() {
        super.configUI()
        view.backgroundColor = .white
        setupNavigationBar()
        setupCollectionViewHiddenState(with: false)
    }
    
    // MARK: - func
    
    private func bind() {
        backButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func setupNavigationBar() {
        title = "봐야 하는 콘텐츠"
        setupBaseNavigationBar(backgroundColor: .havitWhite,
                               titleColor: .primaryBlack,
                               isTranslucent: false,
                               tintColor: .primaryBlack)
        navigationItem.leftBarButtonItem = makeBarButtonItem(with: backButton)
    }
    
    private func makeBarButtonItem(with button: UIButton) -> UIBarButtonItem {
        return UIBarButtonItem(customView: button)
    }
    
    private func setupCollectionViewHiddenState(with hasContent: Bool) {
        contentCollectionView.isHidden = !hasContent
    }
}

extension MainRecentViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ContentsCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.backgroundColor = .white
        return cell
    }
}
