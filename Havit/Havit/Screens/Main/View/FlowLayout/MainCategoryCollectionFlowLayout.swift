//
//  MainCategoryCollectionFlowLayout.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/16.
//

import UIKit
import SwiftUI

final class MainCategoryCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    // MARK: - property
    
    private var row: Int
    private var column: Int
    private var pageWidth: CGFloat
    private var pageHeight: CGFloat
    private var attributesArray: [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    
    // MARK: - init
    
    init(row: Int, column: Int, pageWidth: CGFloat = 0.0, pageHeight: CGFloat = 0.0) {
        self.row = row
        self.column = column
        self.pageWidth = pageWidth
        self.pageHeight = pageHeight
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var collectionViewContentSize: CGSize {
        let decimalPageCount: Double = Double(attributesArray.count) / Double(row * column)
        let pageCount = ceil(decimalPageCount)
        let height: CGFloat = pageHeight
        var width: CGFloat = pageWidth
        
        switch scrollDirection {
        case .horizontal:
            width = CGFloat(pageCount) * pageWidth
        default:
            break
        }
        
        return CGSize(width: width, height: height)
    }
    
    override func prepare() {
        let isPageWidthZero = (pageWidth == .zero)
        let isPageHeightZero = (pageHeight == .zero)
        if isPageWidthZero {
            pageWidth = collectionView?.frame.width ?? UIScreen.main.bounds.size.width
        }
        if isPageHeightZero {
            pageHeight = collectionView?.frame.height ?? UIScreen.main.bounds.size.height
        }
        
        let rowWidth: CGFloat = pageWidth - minimumInteritemSpacing * CGFloat(row - 1)
        let rowHeight: CGFloat = pageHeight - minimumLineSpacing * CGFloat(column - 1)
        let rightEdgeInset = sectionInset.right
        let topEdgeInset = sectionInset.top
        let itemSizeWidth: CGFloat = rowWidth / CGFloat(row) - rightEdgeInset
        let itemSizeHeight: CGFloat = rowHeight / CGFloat(column) - topEdgeInset
        self.itemSize = CGSize(width: itemSizeWidth, height: itemSizeHeight)
        
        let itemCount: Int = collectionView?.numberOfItems(inSection: 0) ?? 0
        if itemCount > 0 {
            (0...itemCount-1).forEach { item in
                let indexPath = IndexPath(item: item, section: 0)
                let attributes = layoutAttributesForItem(at: indexPath)
                attributesArray.append(attributes!)
            }
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributesArray
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        let rightEdgeInset = sectionInset.right
        let topEdgeInset = sectionInset.top
        let itemIndex: Int = indexPath.item
        let itemRow: CGFloat = CGFloat(itemIndex % row)
        let itemColumn: CGFloat = CGFloat(itemIndex / row % column)
        let page: Int = itemIndex / (row * column)
        var originX: CGFloat = 0.0
        var originY: CGFloat = 0.0
        
        switch scrollDirection {
        case .horizontal:
            let totalPageWidth: CGFloat = CGFloat(page) * pageWidth
            originX = itemRow * (itemSize.width + minimumInteritemSpacing) + totalPageWidth + rightEdgeInset
            originY = itemColumn * (itemSize.height + minimumLineSpacing)  + topEdgeInset
        default:
            break
        }
        
        attribute.frame = CGRect(x: originX,
                                 y: originY,
                                 width: itemSize.width,
                                 height: itemSize.height)
        
        return attribute
    }
}
