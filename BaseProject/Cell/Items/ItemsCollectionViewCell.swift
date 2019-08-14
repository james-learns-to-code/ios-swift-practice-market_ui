//
//  ItemsCollectionViewCell.swift
//  BaseProject
//
//  Created by leedongseok on 02/08/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import UIKit

final class ItemsCollectionViewCell: UICollectionViewCell {
    
    // MARK: Interface
    func configure(items: [ItemModel]?) {
        self.items = items
    }
 
    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
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
    
    private var items: [ItemModel]? {
        didSet {
            collectionView.reloadData()
        }
    }
    private var itemCount: Int {
        return items?.count ?? 0
    }
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(
            fixedMinimumInteritemSpacing: ItemsCollectionViewCell.itemSpace,
            sectionInset: UIEdgeInsets(side: ItemsCollectionViewCell.sectionSpace))
        view.delegate = self
        view.dataSource = self
        view.register(ItemCollectionViewCell.self)
        return view
    }()
    
    private static let sectionSpace: CGFloat = 30
    private static let itemSpace: CGFloat = 5
    static let numOfRow: CGFloat = 2
    static func getItemSize(width: CGFloat) -> CGSize {
        let widthWithoutSpace = width - (sectionSpace * 2)
        let widthDividedRow = floor(widthWithoutSpace / numOfRow)
        let spaceDividedRow = (numOfRow - 1) * itemSpace
        let itemWidth = widthDividedRow - spaceDividedRow
        let itemHeight = itemWidth + ItemCollectionViewCell.labelHeight
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

extension ItemsCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = ItemsCollectionViewCell.getItemSize(width: collectionView.frame.width)
        return size
    }
}

extension ItemsCollectionViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt")
    }
}

extension ItemsCollectionViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let maxCount = min(itemCount, ShopViewModel.numOfMaxItem)
        return maxCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ItemCollectionViewCell.dequeue(from: collectionView, for: indexPath)!
        let item = items?[safe: indexPath.row]
        cell.configure(imageUrlStr: item?.image, title: item?.title, promotion: item?.promotion, price: item?.price)
        return cell
    }
}
