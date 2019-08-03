//
//  BannersTableViewCell.swift
//  BaseProject
//
//  Created by leedongseok on 31/07/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import UIKit

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
        contentView.addSubviewWithFullsize(collectionView)
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
        view.register(BannerCollectionViewCell.self)
        view.clipsToBounds = false
        view.alwaysBounceHorizontal = true
        view.decelerationRate = .fast
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    // MARK: Peek scrolling

    private let overflowSpace: CGFloat = 20
    private let itemSpace: CGFloat = 20
    private var itemSize: CGSize {
        let totalMargin = (itemSpace + overflowSpace) * 2
        let width = collectionView.frame.size.width - totalMargin
        let height = BannersTableViewCell.getHeight(width: width)
        return CGSize(width: width, height: height)
    }
    private var scrollBeginOffset: CGPoint = .zero
    
    // MARK: Height
    
    static func getHeight(width: CGFloat) -> CGFloat {
        let height = BannerCollectionViewCell.getHeight(width: width)
        return height
    }
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
        scrollBeginOffset = scrollView.contentOffset
    }
    
    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let pageWidth = itemSize.width + itemSpace
        // Scroll if user scrolling only 10% of page width
        let snapTolerance: CGFloat = 0.1
        let snapDelta: CGFloat = (scrollView.contentOffset.x > scrollBeginOffset.x) ?
            1 - snapTolerance : snapTolerance
        let widthForSnapping = pageWidth * snapDelta
        let snappedOffest = scrollView.contentOffset.x + widthForSnapping
        let pageIndex = floor(snappedOffest / pageWidth)
        let pageOffset = pageWidth * pageIndex
        targetContentOffset.pointee = CGPoint(x: pageOffset, y: targetContentOffset.pointee.y)
    }
}

extension BannersTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banners?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = BannerCollectionViewCell.dequeue(from: collectionView, for: indexPath)!
        let banner = banners?[safe: indexPath.row]
        cell.configure(imageUrlStr: banner?.image, title: banner?.title, subTitle: banner?.sub_title)
        return cell
    }
}
