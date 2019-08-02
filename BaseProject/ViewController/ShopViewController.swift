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
    private weak var categoryCell: ProductCategoryTableViewCell?
    private weak var itemCell: CategoryItemsTableViewCell?
    
    // MARK: View switching
    
    private lazy var customView: ShopView = {
        let view = ShopView(delegate: self, dataSource: self)
        return view
    }()
    
    private lazy var footerView: CompanyFooterView = {
        let view = CompanyFooterView()
        view.updateHeight(isShrink: true)
        view.delegate = self
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
        setupNavigationBar()
        setupBinding()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        title = "BTS"
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
}

extension ShopViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.delegate?.tableView?(tableView, heightForRowAt: indexPath) ?? UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case Section.banner.rawValue:
            return BannersTableViewCell.getHeight(width: tableView.frame.width)
        case Section.product.rawValue:
            switch indexPath.row {
            case Section.ProductRow.category.rawValue:
                return ProductCategoryTableViewCell.getHeight()
            case Section.ProductRow.item.rawValue:
                let currentIndexPath = categoryCell?.selectedIndexPath ?? IndexPath(row: 0, section: 0)
                let items = viewModel.products?[safe: currentIndexPath.row]?.items
                return CategoryItemsTableViewCell.getHeight(width: tableView.frame.width, items: items)
            default:
                break
            }
        case Section.recent.rawValue:
            return RecentTableViewCell.height
        case Section.notice.rawValue:
            return NoticeTableViewCell.height
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case Section.product.rawValue:
            return CGFloat(ShopViewModel.productSectionHeight)
        case Section.recent.rawValue:
            return CGFloat(ShopViewModel.recentSectionHeight)
        case Section.notice.rawValue:
            return CGFloat(ShopViewModel.noticeSectionHeight)
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case Section.banner.rawValue:
            return CGFloat(ShopViewModel.bannerFooterHeight)
        case Section.product.rawValue:
            return CGFloat(ShopViewModel.productFooterHeight)
        case Section.recent.rawValue:
            return CGFloat(ShopViewModel.recentFooterHeight)
        case Section.notice.rawValue:
            return footerView.frame.height
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case Section.product.rawValue:
            let label = UILabel(color: .white)
            label.text = "     \(ShopViewModel.productSectionTitle)"
            return label
        case Section.recent.rawValue:
            let label = UILabel(color: .white)
            label.text = "     \(ShopViewModel.recentSectionTitle)"
            return label
        case Section.notice.rawValue:
            let label = UILabel(color: .white)
            label.text = "     \(ShopViewModel.noticeSectionTitle)"
            return label
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == Section.notice.rawValue {
            return footerView
        }
        return nil
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case Section.banner.rawValue:
            let cell = BannersTableViewCell.dequeue(from: tableView, for: indexPath)!
            cell.configure(banners: viewModel.banners)
            return cell
        case Section.product.rawValue:
            switch indexPath.row {
            case Section.ProductRow.category.rawValue:
                let cell = ProductCategoryTableViewCell.dequeue(from: tableView, for: indexPath)!
                categoryCell = cell
                cell.delegate = self
                cell.configure(products: viewModel.products)
                return cell
            case Section.ProductRow.item.rawValue:
                let cell = CategoryItemsTableViewCell.dequeue(from: tableView, for: indexPath)!
                itemCell = cell
                cell.delegate = self
                cell.configure(products: viewModel.products)
                return cell
            default:
                break
            }
        case Section.recent.rawValue:
            let cell = RecentTableViewCell.dequeue(from: tableView, for: indexPath)!
            cell.configure(items: viewModel.recents)
            return cell
        case Section.notice.rawValue:
            let cell = NoticeTableViewCell.dequeue(from: tableView, for: indexPath)!
            let notice = viewModel.notice(at: indexPath.row)
            cell.configure(notice: notice)
            return cell
        default:
            break
        }
        return UITableViewCell.dequeue(from: tableView, for: indexPath)!
    }
}

extension ShopViewController: ProductCategoryTableViewCellDelegate {
    func didTapCategory(_ sender: ProductCategoryTableViewCell, index: Int) {
        itemCell?.select(at: index)
        customView.tableView.beginUpdates()
        customView.tableView.endUpdates()
    }
}

extension ShopViewController: CategoryItemsTableViewCellDelegate {
    func didScroll(_ sender: CategoryItemsTableViewCell, to index: Int) {
        categoryCell?.select(at: index)
        customView.tableView.beginUpdates()
        customView.tableView.endUpdates()
    }
}

extension ShopViewController: CompanyFooterViewDelegate {
    func didTapExpandButton(_ sender: CompanyFooterView) {
        sender.updateHeight(isShrink: !sender.isShrink)
        customView.tableView.reloadData()
//        customView.tableView.beginUpdates()
//        customView.tableView.endUpdates()
    }
}
