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
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: ItemsCollectionViewCell.sectionSpace, bottom: 0, right: ItemsCollectionViewCell.sectionSpace)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = ItemsCollectionViewCell.itemSpace
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.register(ItemCollectionViewCell.self)
        view.isScrollEnabled = false
        view.backgroundColor = .clear
        return view
    }()
    
    static let sectionSpace: CGFloat = 30
    static let itemSpace: CGFloat = 5
    static let numOfRow = 2
    static func getItemSize(width: CGFloat) -> CGSize {
        let width = width - (sectionSpace * 2)
        let itemWidth = CGFloat((Int(width) / numOfRow) - ((numOfRow - 1) * Int(itemSpace)))
        let itemHeight = itemWidth + ItemCollectionViewCell.labelHeight
        return CGSize(width: CGFloat(Int(itemWidth)), height: CGFloat(Int(itemHeight)))
    }
}

extension ItemsCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let size = ItemsCollectionViewCell.getItemSize(width: width)
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
        let count = items?.count ?? 0
        let maxCount = ShopViewModel.getCount(count, max: ShopViewModel.numOfMaxItem)
        return maxCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ItemCollectionViewCell.dequeue(from: collectionView, for: indexPath)!
        let item = items?[safe: indexPath.row]
        cell.configure(imageUrlStr: item?.image, title: item?.title, promotion: item?.promotion, price: item?.price)
        return cell
    }
}
