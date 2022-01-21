//
//  WebViewModel.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/06.
//

import Foundation

import RxSwift

final class WebViewModel {
    
    // MARK: - View -> ViewModel
    
    let urlString: BehaviorSubject<String?>
    let canGoBack: BehaviorSubject<Bool>
    let canGoForward: BehaviorSubject<Bool>
    let isReadContent: BehaviorSubject<Bool>
    
    // MARK: - ViewModel -> View
    
    var urlRequest: Observable<URLRequest>
    
    // MARK: - property
    private let toggleService: ContentToggleService = ContentToggleService(apiService: APIService(),
                                                                           environment: .development)
    private let contentId: Int?
    
    // MARK: - init
    
    init(urlString: String, isReadContent: Bool, contentId: Int?) {
        self.urlString = BehaviorSubject<String?>(value: urlString)
        self.canGoBack = BehaviorSubject(value: false)
        self.canGoForward = BehaviorSubject(value: false)
        self.isReadContent = BehaviorSubject(value: isReadContent)
        self.contentId = contentId
        
        self.urlRequest = self.urlString
            .compactMap { urlString -> String? in
                let isValidUrlString = urlString?.isValidURL ?? false
                let validUrlString = isValidUrlString ? appendHttpPrefixIfNeeded(to: urlString) : getGoogleSearchUrl(withKeyword: urlString)
                return validUrlString
            }
            .compactMap {
                URL(string: $0)
            }
            .compactMap {
                URLRequest(url: $0)
            }
        
        func appendHttpPrefixIfNeeded(to urlString: String?) -> String? {
            guard var urlString = urlString else {
                return nil
            }
            if !urlString.hasPrefix("http") {
                urlString = "http://" + urlString
            }
            return urlString
        }
        
        func getGoogleSearchUrl(withKeyword keyword: String?) -> String {
            let googleSearchUrl = "https://www.google.com/search?q=\(keyword ?? "")"
            return googleSearchUrl
        }
    }
    
    // MARK: - func
    
    func toggleContent() {
        Task {
            do {
                guard let contentId = contentId else {
                    return
                }
                let isSeen = try await toggleService.patchContentToggle(contentId: contentId)?.isSeen
                self.isReadContent.onNext(isSeen ?? false)
            } catch let error {
                self.isReadContent.onError(error)
            }
        }
    }
}

fileprivate extension String {
    var isValidURL: Bool {
        guard let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else {
            return false
        }
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.utf16.count
        } else {
            return false
        }
    }
}
