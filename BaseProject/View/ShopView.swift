//
//  ShopView.swift
//  BaseProject
//
//  Created by leedongseok on 14/06/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import UIKit

final class ShopView: UIView {
     
    // MARK: UI
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.separatorStyle = .none
        view.sectionHeaderHeight = 0
        view.sectionFooterHeight = 0
        view.contentInset.top = -44
        view.contentInset.bottom = CGFloat(ShopViewModel.bottomInset)
        view.register(UITableViewCell.self)
        view.register(BannersTableViewCell.self)
        view.register(ProductCategoryTableViewCell.self)
        view.register(CategoryItemsTableViewCell.self)
        view.register(RecentTableViewCell.self)
        view.register(NoticeTableViewCell.self)
        return view
    }()
    
    // MARK: Lifecycle
    required init(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        super.init(frame: .zero)
        setup()
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
    override init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    private func setup() {
        addTableView()
    }
    private func addTableView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor)
            ])
    }
}
