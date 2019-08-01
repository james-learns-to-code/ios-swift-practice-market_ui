//
//  ShopView.swift
//  BaseProject
//
//  Created by leedongseok on 14/06/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import UIKit

final class ShopView: UIView {
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(UITableViewCell.self)
        view.register(BannersTableViewCell.self)
        return view
    }()
    
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
        addSubviewWithFullsize(tableView) 
    }
}
