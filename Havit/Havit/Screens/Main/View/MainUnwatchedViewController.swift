//
//  MainUnwatchedViewController.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/19.
//

import UIKit

import RxCocoa
import SnapKit

final class MainUnwatchedViewController: BaseViewController {
    
    private enum Size {
        static let cellWidth: CGFloat = UIScreen.main.bounds.size.width
        static let cellHeight: CGFloat = 139
    }
    
    // MARK: - property
    
    weak var coordinator: UnwatchedCoordinator?
    
    private let backButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
        button.setImage(ImageLiteral.btnBackBlack, for: .normal)
        return button
    }()
    private lazy var contentCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: Size.cellWidth, height: Size.cellHeight)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.register(cell: ContentsCollectionViewCell.self)
        return collectionView
    }()
    private let unwatchedEmptyView = MainUnwatchedEmptyView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func render() {
        view.addSubView(unwatchedEmptyView)
        unwatchedEmptyView.addSubview(contentCollectionView)
        
        unwatchedEmptyView.snp.makeConstraints {
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
        title = "봐야 하는 콘텐츠"
    }
    
    // MARK: - func
    
    private func bind() {
        backButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.coordinator?.performTransition(to: .previous)
            })
            .disposed(by: disposeBag)
    }
    
    private func setupNavigationBar() {
        setupBaseNavigationBar(backgroundColor: .havitWhite,
                               titleColor: .primaryBlack,
                               isTranslucent: false,
                               tintColor: .primaryBlack)
        navigationItem.leftBarButtonItem = makeBarButtonItem(with: backButton)
    }
    
    private func makeBarButtonItem(with button: UIButton) -> UIBarButtonItem {
        return UIBarButtonItem(customView: button)
    }
}

extension MainUnwatchedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ContentsCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        return cell
    }
}
