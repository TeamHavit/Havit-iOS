//
//  EntryNavigationViewController.swift
//  ShareExtension
//
//  Created by Noah on 2022/01/14.
//

import UIKit
import Social
import MobileCoreServices

@objc(EntryNavigationViewController)
final class EntryNavigationViewController: UINavigationController {
    
    // MARK: - property
    
    let categoryService: CategorySeriviceable = CategoryService(apiService: APIService(), environment: .development)
    let shareService: ShareServiceable = ShareService(apiService: APIService(), environment: .development)
    var shareObjectUrl: String?
    var categories: [Category] = []
    var targetContent: TargetContent?

    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        getShareObjectUrl { [weak self] in
            self?.getShareExtensionData()
        }
    }
    
    // MARK: - func
    
    private func configUI() {
        view.backgroundColor = .white
        setupBaseNavigationBar()
    }
    
    private func getShareExtensionData() {
        Task {
            do {
                guard let shareObjectUrl = shareObjectUrl else {
                    return
                }
                
                async let categories = try await categoryService.getCategory()
                async let targetContents = try await shareService.getTargetContents(targetUrl: shareObjectUrl)
                
                if let categories = try await categories,
                let targetContents = try await targetContents {
                    self.categories = categories
                    self.targetContent = TargetContent(title: targetContents.ogTitle, description: targetContents.ogDescription, ogImage: targetContents.ogImage, ogUrl: targetContents.ogURL)
                }
                branchCategoryNavigate()
            } catch APIServiceError.serverError {
                Logger.debugDescription("serverError")
            } catch APIServiceError.clientError(let message) {
                if let message = message {
                    Logger.debugDescription("clientError:\(message)")
                }
            }
        }
    }
    
    private func branchCategoryNavigate() {
        if categories.isEmpty {
            let categoryEmptyViewController = CategoryEmptyViewController()
            categoryEmptyViewController.targetContent = self.targetContent
            self.pushViewController(categoryEmptyViewController, animated: true)
        } else {
            let selectCategoryViewControllr = SelectCategoryViewController()
            selectCategoryViewControllr.categories = self.categories
            selectCategoryViewControllr.targetContent = self.targetContent
            self.pushViewController(selectCategoryViewControllr, animated: true)
        }
    }
    
    func setupBaseNavigationBar() {
        let appearance = UINavigationBarAppearance()
        let font = UIFont.font(.pretendardBold, ofSize: 16)
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.havitGray, .font: font]
        appearance.shadowColor = .clear
        
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.isTranslucent = false
    }
    
    private func getShareObjectUrl(completionHandler: @escaping () -> Void) {
        if let extensionItems = extensionContext?.inputItems.first as? NSExtensionItem {
            if let itemProviders = extensionItems.attachments {
                for itemProvider in itemProviders {
                    if itemProvider.hasItemConformingToTypeIdentifier("public.url") {
                        itemProvider.loadItem(forTypeIdentifier: "public.url", options: nil, completionHandler: { (url, error) -> Void in
                            if let shareURL = url as? NSURL {
                                if let shareObjectUrl = shareURL.absoluteString {
                                    self.shareObjectUrl = shareObjectUrl
                                    completionHandler()
                                } else {
                                    Logger.debugDescription(error)
                                }
                            }
                        })
                    }
                }
                
            }
        }
    }
}
