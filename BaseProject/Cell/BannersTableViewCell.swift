//
//  BannersTableViewCell.swift
//  BaseProject
//
//  Created by leedongseok on 31/07/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import UIKit

struct BannersTableViewCellModel {
    static let peekSize: Float = 10
}

final class BannersTableViewCell: UITableViewCell {
    
    // MARK: Interface
    func configure(banners: [BannerModel]?) {
        self.banners = banners
    }
    
    // MARK: Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    private func setup() {
        backgroundColor = .white
        addSubviewWithFullsize(collectionView)
    }
    
    private var banners: [BannerModel]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: UI
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = itemSpace
        let totalItemSpacing = itemSpace + overflowSpace
        layout.sectionInset = UIEdgeInsets(top: 0, left: totalItemSpacing, bottom: 0, right: totalItemSpacing)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.register(UICollectionViewCell.self)
        view.clipsToBounds = false
        return view
    }()
    
    // MARK: Peek scrolling

    private let overflowSpace: CGFloat = 20
    private let itemSpace: CGFloat = 20
    private var itemSize: CGSize {
        let width = collectionView.frame.size.width - (itemSpace * 2) - (overflowSpace * 2)
        return CGSize(width: width, height: width * 0.5)
    }
    private var statringScrollingOffset = CGPoint.zero
}

extension BannersTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSize
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return itemSpace
    }
}

extension BannersTableViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt")
    }
    
    // MARK: Peek scrolling
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        statringScrollingOffset = scrollView.contentOffset
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let itemWidthWithSpace = itemSize.width + (itemSpace * 2)
        let offset = scrollView.contentOffset.x + scrollView.contentInset.left
        let proposedPage = offset / max(1, itemWidthWithSpace)
        let snapPoint: CGFloat = 0.1
        let snapDelta: CGFloat = (offset > statringScrollingOffset.x) ? (1 - snapPoint) : snapPoint
        
        let page: CGFloat
        if floor(proposedPage + snapDelta) == floor(proposedPage) {
            page = floor(proposedPage)
        } else {
            page = floor(proposedPage + 1)
        }
        targetContentOffset.pointee = CGPoint(x: (itemWidthWithSpace * page) - (itemSpace * page), y: targetContentOffset.pointee.y)
    }
}

extension BannersTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banners?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell.dequeue(from: collectionView, for: indexPath)!
        cell.backgroundColor = [UIColor.red, UIColor.blue, UIColor.green, UIColor.purple, UIColor.yellow, UIColor.orange][indexPath.row]
        return cell
    }
}