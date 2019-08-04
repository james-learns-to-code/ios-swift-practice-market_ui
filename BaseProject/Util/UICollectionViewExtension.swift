//
//  UICollectionViewExtension.swift
//  BaseProject
//
//  Created by leedongseok on 01/08/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import UIKit

extension UICollectionView {
    public func register(_ cellClass: AnyClass) {
        register(cellClass, forCellWithReuseIdentifier: String(describing: cellClass))
    }
}

public protocol UICollectionViewCellDequeueable {}
public extension UICollectionViewCellDequeueable where Self: UICollectionViewCell {
    static func dequeue(from collectionView: UICollectionView, for indexPath: IndexPath) -> Self? {
        return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: self), for: indexPath) as? Self
    }
}

extension UICollectionViewCell: UICollectionViewCellDequeueable {}

extension UICollectionView {
    public func isCellFullyVisible(indexPath: IndexPath) -> Bool {
        guard let cell = cellForItem(at: indexPath) else { return false }
        let relativeRect = convert(cell.frame, to: superview)
        return frame.contains(relativeRect)
    }
}

extension UICollectionView {
    
    convenience init(horizontalWithMinimumInteritemSpacing: CGFloat, minimumLineSpacing: CGFloat = 0, sectionInset: UIEdgeInsets = .zero) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = horizontalWithMinimumInteritemSpacing
        layout.minimumLineSpacing = minimumLineSpacing
        layout.sectionInset = sectionInset
        self.init(frame: .zero, collectionViewLayout: layout)
        clipsToBounds = false
        alwaysBounceHorizontal = true
        decelerationRate = .fast
        backgroundColor = .clear
        showsHorizontalScrollIndicator = false
    }
    
    convenience init(fixedMinimumInteritemSpacing: CGFloat, minimumLineSpacing: CGFloat = 0, sectionInset: UIEdgeInsets = .zero) {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = fixedMinimumInteritemSpacing
        layout.minimumLineSpacing = minimumLineSpacing
        layout.sectionInset = sectionInset
        self.init(frame: .zero, collectionViewLayout: layout)
        isScrollEnabled = false
        clipsToBounds = false
        decelerationRate = .fast
        backgroundColor = .clear
    }
}
