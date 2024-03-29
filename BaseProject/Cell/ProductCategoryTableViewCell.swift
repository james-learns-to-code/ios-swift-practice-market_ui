//
//  ProductCategoryTableViewCell.swift
//  BaseProject
//
//  Created by leedongseok on 02/08/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import UIKit

protocol ProductCategoryTableViewCellDelegate: class {
    func didTapCategory(_ sender: ProductCategoryTableViewCell, index: Int)
}

final class ProductCategoryTableViewCell: UITableViewCell {
    weak var delegate: ProductCategoryTableViewCellDelegate?
    
    // MARK: Interface
    
    func configure(products: [ProductModel]?) {
        self.products = products
        let indexPath = selectedIndexPath ?? IndexPath(row: 0, section: 0)
        select(at: indexPath.row)
    }
    
    func select(at index: Int) {
        selectedIndexPath = IndexPath(row: index, section: 0)
        collectionView.selectItem(
            at: IndexPath(row: index, section: 0),
            animated: true,
            scrollPosition: .centeredHorizontally)
    }
    
    static func getHeight() -> CGFloat {
        return CategoryCollectionViewCell.getSize(name: "Test").height
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
    
    private var products: [ProductModel]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: UI
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(
            horizontalWithMinimumInteritemSpacing: itemSpace,
            sectionInset: UIEdgeInsets(side: overflowSpace))
        view.delegate = self
        view.dataSource = self
        view.register(CategoryCollectionViewCell.self)
        return view
    }()
    
    private var selectedIndexPath: IndexPath? {
        willSet (newValue) {
            guard let selectedIndexPath = selectedIndexPath else { return }
            if selectedIndexPath != newValue {
                collectionView.deselectItem(at: selectedIndexPath, animated: true)
            }
        }
    }

    private let overflowSpace: CGFloat = 20
    private let itemSpace: CGFloat = 5
}

extension ProductCategoryTableViewCell: UICollectionViewDelegateFlowLayout { 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let product = products?[safe: indexPath.row]
        return CategoryCollectionViewCell.getSize(name: product?.category_name)
    }
}

extension ProductCategoryTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        delegate?.didTapCategory(self, index: indexPath.row)
        focusCell(at: indexPath)
    }
    private func focusCell(at indexPath: IndexPath) {
        guard collectionView.isCellFullyVisible(indexPath: indexPath) == false else { return }
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

extension ProductCategoryTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CategoryCollectionViewCell.dequeue(from: collectionView, for: indexPath)!
        let product = products?[safe: indexPath.row]
        cell.configure(name: product?.category_name)
        return cell
    }
}
