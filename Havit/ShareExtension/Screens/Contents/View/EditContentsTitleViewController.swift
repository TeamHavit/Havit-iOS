//
//  EditContentsTitleViewController.swift
//  ShareExtension
//
//  Created by Noah on 2022/01/20.
//

import UIKit

import SnapKit

final class EditContentsTitleViewController: BaseViewController {
    
    // MARK: - property
    
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
        label.text = "콘텐츠 제목을 수정하세요"
        label.font = .font(.pretendardSemibold, ofSize: 22)
        label.textColor = .gray005
        return label
    }()
    
    private let editContentsTipNoticeLabel: UILabel = {
        let label = UILabel()
        label.text = "TIP. 알아보기 쉬운 제목은 어때요?"
        label.font = .font(.pretendardSemibold, ofSize: 15)
        label.textColor = .gray003
        return label
    }()
    
    private let contentsTitleTextView: UITextView = {
        let textView = UITextView()
        textView.font = .font(.pretendardMedium, ofSize: 20)
        textView.text = "콘텐츠 제목 어쩌구 저쩌구 블라블라 TIP"
        textView.textAlignment = .center
        textView.textColor = .gray004
        textView.tintColor = .havitPurple
        return textView
    }()

    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setKeyboard()
    }
    // MARK: - func
    
    override func configUI() {
        setNavigationBar()
    }
    
    override func render() {
        view.addSubViews([editContentsNoticeLabel,
                          editContentsTipNoticeLabel,
                          contentsTitleTextView])
        
        editContentsNoticeLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
            $0.leading.equalToSuperview().inset(16)
        }
        
        editContentsTipNoticeLabel.snp.makeConstraints {
            $0.top.equalTo(editContentsNoticeLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(editContentsNoticeLabel)
        }
        
        contentsTitleTextView.snp.makeConstraints {
            $0.top.equalTo(editContentsTipNoticeLabel.snp.bottom).offset(123)
            $0.leading.equalTo(editContentsNoticeLabel)
            $0.trailing.equalToSuperview().inset(35)
            $0.bottom.equalTo(147)
        }
    }
    
    private func setNavigationBar() {
        title = "콘텐츠 저장"
        navigationItem.leftBarButtonItem = navigationLeftButton
        navigationItem.rightBarButtonItem = navigationRightButton
    }
    
    private func setKeyboard() {
        contentsTitleTextView.becomeFirstResponder()
    }
}
