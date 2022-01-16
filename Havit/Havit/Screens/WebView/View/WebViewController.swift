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
import SnapKit

final class WebViewController: BaseViewController {
    
    enum Size {
        static let urlTextFieldWidth: CGFloat = {
            let viewWidth = UIScreen.main.bounds.width
            let barButtonWidth: CGFloat = 44
            return viewWidth - (barButtonWidth * 2)
        }()
        static let urlTextFieldHeight: CGFloat = 33
    }
    
    // MARK: - property
    
    weak var coordinator: WebViewCoordinator?
    private let viewModel: WebViewModel
    
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
                                 size: CGSize(width: Size.urlTextFieldWidth,
                                              height: Size.urlTextFieldHeight))
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
    
    private let toolbar = WebViewToolbar()
    
    // MARK: - init
    
    init(urlString: String) {
        viewModel = WebViewModel(urlString: urlString)
        super.init()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindInput()
        bindOutput()
    }
    
    // MARK: - func
    
    override func render() {
        view.addSubview(toolbar)
        toolbar.snp.makeConstraints {
            $0.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        view.addSubview(webView)
        webView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(toolbar.snp.top)
        }
    }
    
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
    
    private func bindInput() {
        navigationBackBarButton.rx
            .tap
            .bind { [weak self] _ in
                self?.coordinator?.performTransition(to: .previous)
            }
            .disposed(by: disposeBag)
        
        urlTextField.rx
            .controlEvent(.editingDidEndOnExit)
            .map { [weak self] _ in
                self?.urlTextField.text
            }
            .bind(to: viewModel.urlString)
            .disposed(by: disposeBag)
        
        reloadUrlBarButton.rx
            .tap
            .bind { [weak self] _ in
                self?.webView.reload()
            }
            .disposed(by: disposeBag)
       
        toolbar.backBarButton.rx
            .tap
            .bind { [weak self] _ in
                self?.webView.goBack()
            }
            .disposed(by: disposeBag)
        
        toolbar.forwardBarButton.rx
            .tap
            .bind { [weak self] _ in
                self?.webView.goForward()
            }
            .disposed(by: disposeBag)
        
        toolbar.shareBarButton.rx
            .tap
            .compactMap { [weak self] in
                self?.webView.url
            }
            .bind { [weak self] url in
                let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
                self?.present(activityViewController, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    private func bindOutput() {
        viewModel.urlRequest
            .bind { [weak self] urlRequest in
                self?.webView.load(urlRequest)
            }
            .disposed(by: disposeBag)
        
        viewModel.canGoBack
            .asDriver(onErrorJustReturn: false)
            .drive(toolbar.backBarButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.canGoBack
            .map { canGoBack in
                let backImage = canGoBack ? ImageLiteral.iconBackspaceBlack : ImageLiteral.iconBackspaceGray
                return backImage.withRenderingMode(.alwaysOriginal)
            }
            .asDriver(onErrorJustReturn: UIImage())
            .drive(toolbar.backBarButton.rx.image)
            .disposed(by: disposeBag)
        
        viewModel.canGoForward
            .asDriver(onErrorJustReturn: false)
            .drive(toolbar.forwardBarButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.canGoForward
            .map { canGoForward in
                let forwardImage = canGoForward ? ImageLiteral.iconForwardBlack : ImageLiteral.iconForwardGray
                return forwardImage.withRenderingMode(.alwaysOriginal)
            }
            .asDriver(onErrorJustReturn: UIImage())
            .drive(toolbar.forwardBarButton.rx.image)
            .disposed(by: disposeBag)
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
        viewModel.canGoBack.onNext(webView.canGoBack)
        viewModel.canGoForward.onNext(webView.canGoForward)
    }
    
    private func setUrlTextFieldText(with url: String?) {
        urlTextField.text = url
    }
}
