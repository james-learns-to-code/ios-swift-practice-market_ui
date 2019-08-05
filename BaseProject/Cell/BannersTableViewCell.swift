//
//  BannersTableViewCell.swift
//  BaseProject
//
//  Created by leedongseok on 31/07/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import UIKit

final class BannersTableViewCell: UITableViewCell {
    typealias SelfClass = BannersTableViewCell
    
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
        let view = UICollectionView(
            horizontalWithMinimumInteritemSpacing: 0,
            minimumLineSpacing: SelfClass.lineSpace,
            sectionInset: UIEdgeInsets(side: SelfClass.totalSpace))
        view.delegate = self
        view.dataSource = self
        view.register(BannerCollectionViewCell.self)
        return view
    }()
    
    // MARK: Peek scrolling

    private static let overflowSpace: CGFloat = 20
    private static let lineSpace: CGFloat = 20
    private static let totalSpace: CGFloat = lineSpace + overflowSpace
    private var itemSize: CGSize {
        let totalMargin = SelfClass.totalSpace * 2
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
        
        let pageWidth = itemSize.width + SelfClass.lineSpace
        // Scroll if user scrolling only 10% of page width
        let snapTolerance: CGFloat = 0.1
        let snapDelta: CGFloat = scrollView.contentOffset.x > scrollBeginOffset.x ?
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
