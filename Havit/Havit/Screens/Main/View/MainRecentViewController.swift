//
//  MainRecentViewController.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/20.
//

import UIKit

import RxCocoa
import SnapKit

final class MainRecentViewController: BaseViewController {
    
    private enum Size {
        static let cellWidth: CGFloat = UIScreen.main.bounds.size.width
        static let cellHeight: CGFloat = 139
    }
    
    // MARK: - property
    
    private let mainService: MainService = MainService(apiService: APIService(),
                                                       environment: .development)
    private let toggleService: ContentToggleService = ContentToggleService(apiService: APIService(),
                                                                           environment: .development)
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
        collectionView.delegate = self
        collectionView.register(cell: ContentsCollectionViewCell.self)
        return collectionView
    }()
    private let recentEmptyView = MainContentEmptyView(guideText:
                                                            "최근에 저장한 콘텐츠가 없습니다.\n새로운 콘텐츠를 저장해 보세요!")
    private var contents: [Content] = []
    
    // MARK: - init
    
    override init() {
        super.init()
        hidesBottomBarWhenPushed = true
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getRecentContent()
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
        setupCollectionViewHiddenState(with: true)
    }
    
    // MARK: - func
    
    private func setupEmptyView(with contents: [Content]) {
        let isContentEmpty = contents.isEmpty
        
        contentCollectionView.isHidden = isContentEmpty
    }
    
    private func bind() {
        backButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func setupNavigationBar() {
        title = "최근 저장 콘텐츠"
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
    
    // MARK: - network
    
    private func getRecentContent() {
        Task {
            do {
                async let recentContent = try await mainService.getRecentContent()
                
                if let content = try await recentContent {
                    self.contents = content
                    contentCollectionView.reloadData()
                    setupEmptyView(with: content)
                }
            } catch APIServiceError.serverError {
                print("serverError")
            } catch APIServiceError.clientError(let message) {
                print("clientError:\(String(describing: message))")
            }
        }
    }
    
    private func patchContentToggle(contentId: Int, item: Int) {
        Task {
            do {
                async let contentToggle = try await toggleService.patchContentToggle(contentId: contentId)
                
                if let contentToggle = try await contentToggle,
                   let isSeen = contentToggle.isSeen {
                    let indexPath = IndexPath(item: item, section: 0)
                    guard
                        let cell = contentCollectionView.cellForItem(at: indexPath) as? ContentsCollectionViewCell
                    else { return }
                    
                    print(isSeen)
                    cell.isReadButton.setImage(isSeen ? ImageLiteral.btnContentsRead : ImageLiteral.btnContentsUnread, for: .normal)
                }
            } catch APIServiceError.serverError {
                print("serverError")
            } catch APIServiceError.clientError(let message) {
                print("clientError:\(String(describing: message))")
            }
        }
    }
}

extension MainRecentViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ContentsCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.backgroundColor = .white
        cell.update(content: contents[indexPath.item])
        cell.didTapIsReadButton = { [weak self] contentId, item in
            self?.patchContentToggle(contentId: contentId, item: item)
        }
        return cell
    }
}

extension MainRecentViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = indexPath.item
        if let url = contents[item].url,
           let isReadContent = contents[item].isSeen {
            let webViewController = WebViewController(urlString: url, isReadContent: isReadContent)
            navigationController?.pushViewController(webViewController, animated: true)
        }
    }
}
