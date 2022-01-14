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
    
    // MARK: - ViewModel -> View
    
    var urlRequest: Observable<URLRequest>
    
    init(urlString: String) {
        self.urlString = BehaviorSubject<String?>(value: urlString)
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
