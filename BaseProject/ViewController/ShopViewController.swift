//
//  ShopViewController.swift
//  BaseProject
//
//  Created by leedongseok on 14/06/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import UIKit

final class ShopViewController: UIViewController {
    private let viewModel = ShopViewModel()
    
    typealias Section = ShopViewModel.Section

    // MARK: View switching
    
    private lazy var customView: ShopView = {
        let view = ShopView(delegate: self, dataSource: self)
        return view
    }()
    
    override func loadView() {
        super.loadView()
        view = customView
        setup()
        viewModel.fetchFeed()
    }
    
    // MARK: Setup
    
    private func setup() {
        setupBinding()
    }
    
    private func setupBinding() {
        viewModel.feed.bind() { [weak self] feed in
            DispatchQueue.main.async {
                self?.reload()
            }
        }
    }
    
    private func reload() {
        customView.tableView.reloadData()
    }
    
    // MARK: UI
    
//    private lazy var bannerCell: BannersTableViewCell = {
//        let cell = BannersTableViewCell.dequeue(from: customView.tableView)!
//        return cell
//    }()
    private lazy var productCell: BannersTableViewCell = {
        let cell = BannersTableViewCell.dequeue(from: customView.tableView)!
        return cell
    }()
    private lazy var recentCell: BannersTableViewCell = {
        let cell = BannersTableViewCell.dequeue(from: customView.tableView)!
        return cell
    }()
}

extension ShopViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case Section.banner.rawValue:
            return 200
        default:
            break
        }
        return 0
    }
}

extension ShopViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case Section.banner.rawValue:
            let cell = BannersTableViewCell.dequeue(from: customView.tableView)!
            cell.configure(banners: viewModel.banners)
            return cell
        case Section.product.rawValue:
            return productCell
        case Section.recent.rawValue:
            return recentCell
        case Section.notice.rawValue:
            let notice = viewModel.notice(at: indexPath.row)
            let cell = BannersTableViewCell.dequeue(from: tableView, for: indexPath)!
            return cell
        default:
            return UITableViewCell.dequeue(from: tableView, for: indexPath)!
        } 
    }
}
