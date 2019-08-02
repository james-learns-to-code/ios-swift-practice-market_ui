//
//  CategoryItemsTableViewCell.swift
//  BaseProject
//
//  Created by leedongseok on 02/08/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import UIKit

protocol CategoryItemsTableViewCellDelegate: class {
    func didScroll(_ sender: CategoryItemsTableViewCell, to index: Int)
}

final class CategoryItemsTableViewCell: UITableViewCell {
    weak var delegate: CategoryItemsTableViewCellDelegate?
    
    // MARK: Interface
    
    func configure(products: [ProductModel]?) {
        self.products = products
    }
    
    func select(at index: Int) {
        collectionView.scrollToItem(
            at: IndexPath(row: index, section: 0),
            at: .left,
            animated: false)
    }
    
    var currentIndexPath: IndexPath? {
        return visibleCurrentCellIndexPath
    }

    static func getHeight(width: CGFloat, items: [ItemModel]?) -> CGFloat {
        let size = getItemSize(width: width, items: items)
        return size.height
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
        viewHeightConstraint = heightAnchor.constraint(equalToConstant: 0)
        addSubviewWithFullsize(collectionView)
    }
    
    private var products: [ProductModel]? {
        didSet {
            collectionView.reloadData()
        }
    }
 
    // MARK: UI
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateViewHeight()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    private var viewHeightConstraint: NSLayoutConstraint?
    private func updateViewHeight() {
        let indexPath = currentIndexPath ?? IndexPath(row: 0, section: 0)
        let items = products?[safe: indexPath.row]?.items
        let height = CategoryItemsTableViewCell.getItemSize(width: collectionView.frame.width, items: items).height
        viewHeightConstraint?.constant = height
        viewHeightConstraint?.isActive = true
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = .zero
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.register(ItemsCollectionViewCell.self)
        view.isPagingEnabled = true
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
        return view
    }()

    private static func getItemSize(width: CGFloat, items: [ItemModel]?) -> CGSize {
        let itemSize = ItemsCollectionViewCell.getItemSize(width: width)
        let count = (items?.count ?? 0)
        let maxCount = count > ShopViewModel.numOfMaxItem ? ShopViewModel.numOfMaxItem : count
        let rowNum = Int(ceil(Double(maxCount) / Double(ItemsCollectionViewCell.numOfRow)))
        let itemsHeight = itemSize.height * CGFloat(rowNum)
        return CGSize(width: CGFloat(Int(width)), height: CGFloat(Int(itemsHeight)))
    }
}

extension CategoryItemsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let items = products?[safe: indexPath.row]?.items
        let size = CategoryItemsTableViewCell.getItemSize(width: width, items: items)
        return size
    }
}

extension CategoryItemsTableViewCell: UICollectionViewDelegate {
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt")
    }
     
    private var visibleCurrentCellIndexPath: IndexPath? {
        for cell in self.collectionView.visibleCells {
            let indexPath = self.collectionView.indexPath(for: cell)
            return indexPath
        }
        return nil
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let newIndexPath = visibleCurrentCellIndexPath else { return }
        delegate?.didScroll(self, to: newIndexPath.row)
        setNeedsLayout()
    }
}

extension CategoryItemsTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ItemsCollectionViewCell.dequeue(from: collectionView, for: indexPath)!
        if let items = products?[safe: indexPath.row]?.items {
            cell.configure(items: items)
        }
        return cell
    }
}
