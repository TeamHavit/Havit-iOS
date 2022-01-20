//
//  SetAlertViewController.swift
//  ShareExtension
//
//  Created by Noah on 2022/01/20.
//

import UIKit

import SnapKit

final class SetAlertViewController: BaseViewController {
    
    // MARK: - property
    
    enum AlertTimeType: Int, CaseIterable {
        case oneHourLater = 0
        case twoHourLater = 1
        case threeHourLater = 2
        case tomorrowAtThisTime = 3
        
        var description: String {
            switch self {
            case .oneHourLater:
                return "1시간 후"
            case .twoHourLater:
                return "2시간 후"
            case .threeHourLater:
                return "3시간 후"
            case .tomorrowAtThisTime:
                return "내일 이 시간"
            }
        }
    }
    
    private let navigationLeftButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(image: ImageLiteral.btnBackBlack,
                                            style: .plain,
                                            target: nil,
                                            action: nil)
        barButtonItem.tintColor = .havitGray
        return barButtonItem
    }()
    
    private let navigationRightButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                            target: nil,
                                            action: nil)
        barButtonItem.tintColor = .havitPurple
        return barButtonItem
    }()
    
    private let editContentsNoticeLabel: UILabel = {
        let label = UILabel()
        label.text = "알림받을 시간을 설정하세요"
        label.font = .font(.pretendardSemibold, ofSize: 22)
        label.textColor = .gray005
        return label
    }()
    
    private lazy var selectAlertTimeCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width - 32, height: 50)
        flowLayout.minimumLineSpacing = 7
        flowLayout.minimumInteritemSpacing = 0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.register(cell: SetAlertCollectionViewCell.self)
        return collectionView
    }()

    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegation()
    }
    // MARK: - func
    
    override func configUI() {
        setNavigationBar()
    }
    
    override func render() {
        view.addSubViews([editContentsNoticeLabel,
                          selectAlertTimeCollectionView])
        
        editContentsNoticeLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
            $0.leading.equalToSuperview().inset(16)
        }
        
        selectAlertTimeCollectionView.snp.makeConstraints {
            $0.top.equalTo(editContentsNoticeLabel.snp.bottom).offset(40)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setNavigationBar() {
        title = "콘텐츠 저장"
        navigationItem.leftBarButtonItem = navigationLeftButton
        navigationItem.rightBarButtonItem = navigationRightButton
    }
    
    private func setDelegation() {
        selectAlertTimeCollectionView.delegate = self
    }
}

extension SetAlertViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as SetAlertCollectionViewCell
        if let alertTimeDescription = AlertTimeType(rawValue: indexPath.item)?.description {
            cell.update(alertTime: alertTimeDescription)
        }
        return cell
    }
}

extension SetAlertViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SetAlertCollectionViewCell {
            cell.didSelect()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SetAlertCollectionViewCell {
            cell.didUnSelect()
        }
    }
}
