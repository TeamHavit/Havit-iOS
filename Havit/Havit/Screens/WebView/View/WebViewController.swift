//
//  WebViewController.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/06.
//

import UIKit
import WebKit

final class WebViewController: BaseViewController {
    
    // MARK: - property
    weak var coordinator: WebViewCoordinator?
    private let url: String
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.allowsBackForwardNavigationGestures = true
        webView.uiDelegate = self
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
        loadWebPage(with: url)
    }
    
    // MARK: - func
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
        let okAction = UIAlertAction(title: "확인", style: .default) { (_) in
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
