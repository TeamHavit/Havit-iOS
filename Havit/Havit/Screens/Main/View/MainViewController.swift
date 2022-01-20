//
//  MainViewController.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/06.
//

import UIKit

import RxCocoa
import SnapKit

final class MainViewController: MainTableViewController {
    
    // MARK: - property
    
    private let mainService: MainService = MainService(apiService: APIService(),
                                                       environment: .development)
    private let topView = MainTopView()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appendDummyPresentableCells()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupBarHidden()
        getMainData()
    }
    
    override func render() {
        view.addSubViews([topView, tableView])
        
        topView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(44)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func configUI() {
        view.backgroundColor = .whiteGray
    }
    
    // MARK: - func
    
    private func bind() {
        topView.alarmButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                let alarmViewController = MainAlarmViewController()
                self?.navigationController?.pushViewController(alarmViewController, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func setupBarHidden() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - network
    
    private func getMainData() {
        Task {
            do {
                async let categories = try await mainService.getCategory()
                async let recentContent = try await mainService.getRecentContent()
                async let recommendSite = try await mainService.getRecommendSite()
                async let user = try await mainService.getReachRate()
                
                if let categories = try await categories,
                   let contents = try await recentContent,
                   let recommendSite = try await recommendSite,
                   let user = try await user {
                    self.categories = categories
                    self.contents = contents
                    self.sites = recommendSite
                    self.user = user
                    
                    tableView.reloadData()
                }
            } catch APIServiceError.serverError {
                print("serverError")
            } catch APIServiceError.clientError(let message) {
                print("clientError:\(String(describing: message))")
            }
        }
    }
}
