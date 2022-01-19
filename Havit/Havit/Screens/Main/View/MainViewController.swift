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
    
    private let topView = MainTopView()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appendDummyPresentableCells()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBarHidden()
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
    
    private func setupNavigationBarHidden() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
