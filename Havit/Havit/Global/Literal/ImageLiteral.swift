//
//  ImageLiteral.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/06.
//

import UIKit

enum ImageLiteral {

    // MARK: - Image
    
    static var imgCatchGuide: UIImage { .load(named: "imgCatchGuide") }

}

extension UIImage {
    static func load(named imageName: String) -> UIImage {
        guard let image = UIImage(named: imageName, in: nil, compatibleWith: nil) else {
            return UIImage()
        }
        image.accessibilityIdentifier = imageName
        return image
    }
    
    func resize(to size: CGSize) -> UIImage {
        let image = UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
        return image
    }
}
