//
//  MainCategoryPageControl.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/17.
//

import UIKit

final class MainCategoryPageControl: UIView {
    
    // MARK: - property
    
    var pages: Int = 0 {
        didSet { setNeedsDisplay() }
    }
    var selectedPage: Int = 0 {
        didSet { setNeedsDisplay() }
    }
    var dotColor = UIColor.gray001 {
        didSet { setNeedsDisplay() }
    }
    var selectedColor = UIColor.havitPurple {
        didSet { setNeedsDisplay() }
    }
    private let dotSize: CGFloat = 12
    private let spacing: CGFloat = 3
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        isOpaque = false
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func draw(_ rect: CGRect) {
        (0..<pages).forEach { page in
            (page == selectedPage ? selectedColor : dotColor).setFill()
            
            let center = CGPoint(x: rect.minX + dotSize / 2 + (dotSize + spacing) * CGFloat(page), y: rect.midY)
            let size = CGSize(width: 12, height: 3)
            let rect = CGRect(origin: center, size: size)
            
            UIBezierPath(rect: rect).fill()
        }
    }
}
