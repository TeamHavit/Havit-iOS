//
//  ImageLiteral.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/06.
//

import UIKit

public enum ImageLiteral {

    // MARK: - Image
    
    public static var imgCatchGuide: UIImage { .load(name: "imgCatchGuide") }

}

extension UIImage {
    fileprivate static func load(name: String) -> UIImage {
        guard let image = UIImage(named: name, in: nil, compatibleWith: nil) else {
            assert(false, "\(name) 이미지 로드 실패")
            return UIImage()
        }
        image.accessibilityIdentifier = name
        return image
    }
    
    internal func resize(to length: CGFloat) -> UIImage {
        let newSize = CGSize(width: length, height: length)
        let image = UIGraphicsImageRenderer(size: newSize).image { _ in
            draw(in: CGRect(origin: .zero, size: newSize))
        }
            
        return image
    }
}
