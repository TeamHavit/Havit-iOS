//
//  UICollectionView+Extension.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/10.
//

import UIKit

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.className,
                                                  for: indexPath) as? T else {
            fatalError("Could not find cell with reuseID \(T.className)")
        }
        return cell
    }

    func dequeueHeaderView<T: UICollectionReusableView>(forIndexPath indexPath: IndexPath) -> T {
        guard let view = dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: T.className,
            for: indexPath
        ) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.className)")
        }
        return view
    }

    func dequeueFooterView<T: UICollectionReusableView>(forIndexPath indexPath: IndexPath) -> T {
        guard let view = dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: T.className,
            for: indexPath
        ) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.className)")
        }
        return view
    }

    func register<T>(cell: T.Type,
                     forCellWithReuseIdentifier reuseIdentifier: String = T.className) where T: UICollectionViewCell {
        register(cell, forCellWithReuseIdentifier: reuseIdentifier)
    }
}

