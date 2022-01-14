//
//  WebViewController.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/06.
//

import UIKit
import WebKit

import RxCocoa
import RxSwift

final class WebViewController: BaseViewController {
    
    // MARK: - property
    
    weak var coordinator: WebViewCoordinator?
    private let url: String
    
    private let navigationBackBarButton: UIBarButtonItem = {
        let backButtonImage = UIImage(named: "iconBackBlack")
        let navigationBackBarButton = UIBarButtonItem(image: backButtonImage,
                                                      style: .plain,
                                                      target: nil,
                                                      action: nil)
        return navigationBackBarButton
    }()
    
    private let urlTextField: UITextField = {
        let textField = UITextField()
        textField.frame = CGRect(origin: .zero,
                                 size: CGSize(width: .max, height: 33))
        textField.backgroundColor = .gray000
        textField.layer.cornerRadius = 4
        textField.font = .font(.pretendardReular, ofSize: 16)
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.keyboardType = .URL
        return textField
    }()
    
    private let reloadUrlBarButton: UIBarButtonItem = {
        let reloadImage = UIImage(named: "iconRefresh")
        let reloadUrlBarButton = UIBarButtonItem(image: reloadImage,
                                                 style: .plain,
                                                 target: nil,
                                                 action: nil)
        return reloadUrlBarButton
    }()
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.allowsBackForwardNavigationGestures = true
        webView.uiDelegate = self
        webView.navigationDelegate = self
        return webView
    }()
    
    // MARK: - init
    
    init(url: String) {
        self.url = url
        super.init()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - life cycle
    
    override func loadView() {
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        loadWebPage(with: url)
    }
    
    // MARK: - func
    
    override func configUI() {
        setupBaseNavigationBar()
        setNavigationItem(leftBarButtonItem: navigationBackBarButton,
                          titleView: urlTextField,
                          rightBarButtonItem: reloadUrlBarButton)
    }
    
    private func setNavigationItem(leftBarButtonItem: UIBarButtonItem,
                                   titleView: UIView,
                                   rightBarButtonItem: UIBarButtonItem) {
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.titleView = titleView
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    private func bind() {
        urlTextField.rx
            .controlEvent(.editingDidEndOnExit)
            .compactMap { [weak self] _ -> String? in
                self?.appendHttpPrefixIfNeeded(to: self?.urlTextField.text)
            }
            .subscribe { [weak self] url in
                self?.loadWebPage(with: url)
            }
            .disposed(by: disposeBag)
        
        reloadUrlBarButton.rx
            .tap
            .subscribe { [weak self] _ in
                self?.webView.reload()
            }
            .disposed(by: disposeBag)
    }
    
    private func appendHttpPrefixIfNeeded(to url: String?) -> String? {
        guard var url = url else {
            return nil
        }
        if !url.hasPrefix("http") {
            url = "http://" + url
        }
        return url
    }
    
    private func loadWebPage(with url: String) {
        guard let url = URL(string: url) else {
            return
        }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
}

extension WebViewController: WKUIDelegate {
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            completionHandler()
        }
        showAlert(with: message, alertActions: okAction)
    }

    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            completionHandler(true)
        }
        let cancelAction = UIAlertAction(title: "취소", style: .default) { _ in
            completionHandler(false)
        }
        showAlert(with: message, alertActions: okAction, cancelAction)
    }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if let targetFrame = navigationAction.targetFrame,
           targetFrame.isMainFrame {
            return nil
        }
        
        // href="_blank" 새 창 열기
        webView.load(navigationAction.request)
        return nil
    }
    
    private func showAlert(with message: String, alertActions: UIAlertAction...) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertActions.forEach { alertAction in
            alertController.addAction(alertAction)
        }
        self.present(alertController, animated: true, completion: nil)
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        setUrlTextFieldText(with: webView.url?.description)
    }
    
    private func setUrlTextFieldText(with url: String?) {
        urlTextField.text = url
    }
}
