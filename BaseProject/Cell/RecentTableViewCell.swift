//
//  RecentTableViewCell.swift
//  BaseProject
//
//  Created by leedongseok on 02/08/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import UIKit

final class RecentTableViewCell: UITableViewCell {
    static let height: CGFloat = RecentItemCollectionViewCell.size.height
    
    // MARK: Interface
    func configure(items: [ItemModel]?) {
        self.items = items
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
    
    // MARK: Data
    private var items: [ItemModel]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: UI
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(
            horizontalWithMinimumInteritemSpacing: 0,
            minimumLineSpacing: lineSpace,
            sectionInset: UIEdgeInsets(side: overflowSpace))
        view.delegate = self
        view.dataSource = self
        view.register(RecentItemCollectionViewCell.self) 
        return view
    }()
    
    private let overflowSpace: CGFloat = 20
    private let lineSpace: CGFloat = 5
}

extension RecentTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return RecentItemCollectionViewCell.size
    }
}

extension RecentTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt")
    }
}

extension RecentTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = RecentItemCollectionViewCell.dequeue(from: collectionView, for: indexPath)!
        let item = items?[safe: indexPath.row]
        cell.configure(imageUrlStr: item?.image, title: item?.title)
        return cell
    }
}

