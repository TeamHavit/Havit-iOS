//
//  MorePanModalViewController.swift
//  Havit
//
//  Created by 박예빈 on 2022/01/15.
//

import UIKit

import Kingfisher
import PanModal
import SnapKit

class MorePanModalViewController: BaseViewController, PanModalPresentable {
    
    let categoryContentsService: CategoryContentsSeriviceable = CategoryContentsService(apiService: APIService(),
                                                                environment: .development)
    var previousViewController: CategoryContentsViewController?
    
    var morePanModalCellType: MorePanModalButtonType?
    
    var panScrollable: UIScrollView? {
        return nil
    }
    var shortFormHeight: PanModalHeight = .contentHeight(451)
    var longFormHeight: PanModalHeight = .contentHeight(451)
    var cornerRadius: CGFloat = 30
    
    var contents: Content?
    
    private let moreList = ["제목 수정", "공유", "카테고리 이동", "알림 설정", "삭제"]
    
    private let imageList = [ImageLiteral.iconEdit, ImageLiteral.iconShare, ImageLiteral.iconCategoryMove, ImageLiteral.btnAlarm, ImageLiteral.iconDelete]
    
    var border: UIView = {
        let view = UIView()
        view.backgroundColor = .whiteGray
        return view
    }()
    
    let titleLabel: UILabel  = {
        let label = UILabel()
        label.text = "더보기"
        label.font = UIFont.font(.pretendardSemibold, ofSize: 17)
        label.textColor = .primaryBlack
        label.textAlignment = .center
        return label
    }()
    
    private let topView: UIView = {
        let view = UIView()
        return view
    }()
    
    let topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray001
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    let topTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "헤드라인입니다. 헤드라인입니다. 헤드라인입니다. 헤드라인입니다 헤드라인입니다. 헤드라인입니다 헤드라인입니다. 헤드라인입니다 헤드라인입니다. 헤드라인입니다 헤드라인입니다. 헤드라인입니다"
        label.font = UIFont.font(.pretendardSemibold, ofSize: 14)
        label.textColor = .gray003
        label.numberOfLines = 2
        return label
    }()
    
    let topDateLabel: UILabel = {
        let label = UILabel()
        label.text = "2021.11.24 "
        label.font = UIFont.font(.pretendardReular, ofSize: 9)
        label.textColor = .gray002
        return label
    }()
    
    let topLinkLabel: UILabel = {
        let label = UILabel()
        label.text = "www.brunch.com........d.d.d.d.d.d.d.dd.d.d.d..d.dd."
        label.font = UIFont.font(.pretendardReular, ofSize: 9)
        label.textColor = .gray002
        return label
    }()
    
    let moreTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(cell: MorePanModalTableViewCell.self)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegations()
        if let contentsImageString = contents?.image {
            let url = URL(string: contentsImageString)
            topImageView.kf.setImage(with: url)
        }
        topTitleLabel.text = contents?.title
        topDateLabel.text = contents?.createdAt
        topLinkLabel.text = contents?.url
    }
    
    override func render() {
        view.addSubViews([border, titleLabel, topView, moreTableView])
        topView.addSubViews([topImageView, topTitleLabel, topDateLabel, topLinkLabel])
        
        titleLabel.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(view)
            $0.height.equalTo(60)
        }

        topView.snp.makeConstraints {
            $0.leading.equalTo(view)
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.height.equalTo(84)
        }
        
        border.snp.makeConstraints {
            $0.leading.trailing.equalTo(view)
            $0.height.equalTo(1)
            $0.top.equalTo(titleLabel.snp.bottom)
        }
        
        topImageView.snp.makeConstraints {
            $0.leading.equalTo(view).offset(19)
            $0.top.equalTo(topView).offset(13)
            $0.width.equalTo(63)
            $0.height.equalTo(63)
        }
        
        topTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(topImageView.snp.trailing).offset(16)
            $0.top.equalTo(titleLabel.snp.bottom).offset(14)
            $0.trailing.equalTo(view).inset(36)
        }
        
        topDateLabel.snp.makeConstraints {
            $0.leading.equalTo(topImageView.snp.trailing).offset(16)
            $0.top.equalTo(topTitleLabel.snp.bottom).offset(3)
            $0.width.equalTo(50)
            $0.height.equalTo(10)
            $0.bottom.equalTo(topImageView).inset(5)
        }
        
        topLinkLabel.snp.makeConstraints {
            $0.leading.equalTo(topDateLabel.snp.trailing).offset(3)
            $0.top.equalTo(topTitleLabel.snp.bottom).offset(3)
            $0.trailing.equalTo(view).inset(36)
            $0.height.equalTo(10)
            $0.bottom.equalTo(topImageView).inset(5)
        }
        
        moreTableView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.leading.trailing.equalTo(view)
            $0.height.equalTo(400)
        }
    }
    
    override func configUI() {
        view.backgroundColor = .white
        moreTableView.separatorStyle = .none
    }
    
    private func setDelegations() {
        moreTableView.delegate = self
        moreTableView.dataSource = self
    }
}

extension MorePanModalViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moreList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? MorePanModalTableViewCell else {
            return
        }
        cell.backgroundColor = .purpleCategory
        cell.cellLabel.font = UIFont.font(.pretendardSemibold, ofSize: 16)
        cell.cellLabel.textColor = .havitPurple
        
        switch cell.morePanModalCellType {
        case .editTitle:
            print("editTitle")
        case .share:
            print("share")
        case .goToCategory:
            self.dismiss(animated: true) {
                let manageCategoryViewController = ManageCategoryViewController()
                self.previousViewController?.navigationController?.pushViewController(manageCategoryViewController, animated: true)
            }
        case .setAlarm:
            print("setAlarm")
        case .delete:
            Task {
                do {
                    let categoryContents = try await categoryContentsService.deleteContents(contentID: "\((contents?.id)!)")
            
                    self.dismiss(animated: true) {
                        self.previousViewController?.getCategoryContents()
                        self.previousViewController?.contentsCollectionView.reloadData()
                    }
                } catch APIServiceError.serverError {
                    print("serverError")
                } catch APIServiceError.clientError(let message) {
                    print("clientError:\(message)")
                }
            }
        case .none:
            print("임시 프린트")
        }
    }
}

extension MorePanModalViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withType: MorePanModalTableViewCell.self, for: indexPath)
        cell.cellLabel.text = moreList[indexPath.row]
        cell.cellImageView.image = imageList[indexPath.row]
        cell.selectionStyle = .none
        switch indexPath.row {
        case 0:
            morePanModalCellType = .editTitle
        case 1:
            morePanModalCellType = .share
        case 2:
            morePanModalCellType = .goToCategory
        case 3:
            morePanModalCellType = .setAlarm
        case 4:
            morePanModalCellType = .delete
            cell.cellLabel.textColor = .havitRed
        default:
            print("임시 프린트")
        }
        cell.morePanModalCellType = morePanModalCellType
        return cell
    }
}
