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
    private let url: String
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.allowsBackForwardNavigationGestures = true
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
    }
}
