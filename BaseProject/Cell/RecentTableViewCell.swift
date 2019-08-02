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
    
    private var items: [ItemModel]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: UI
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = itemSpace
        layout.sectionInset = UIEdgeInsets(top: 0, left: overflowSpace, bottom: 0, right: overflowSpace)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.register(RecentItemCollectionViewCell.self)
        view.register(UICollectionViewCell.self)
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    var selectedIndexPath: IndexPath? {
        willSet (newValue) {
            guard let selectedIndexPath = selectedIndexPath else { return }
            if selectedIndexPath != newValue {
                collectionView.delegate?
                    .collectionView?(collectionView, didDeselectItemAt: selectedIndexPath)
            }
        }
    }
    
    private let overflowSpace: CGFloat = 20
    private let itemSpace: CGFloat = 5
    
    static func getHeight() -> CGFloat {
        return CategoryCollectionViewCell.getSize(name: "Test").height
    }
}

extension RecentTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return RecentItemCollectionViewCell.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return itemSpace
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
        if let item = items?[safe: indexPath.row] {
            cell.configure(imageUrlStr: item.image, title: item.title)
        }
        return cell
    }
}

