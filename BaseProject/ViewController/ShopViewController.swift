//
//  ShopViewController.swift
//  BaseProject
//
//  Created by leedongseok on 14/06/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import UIKit

final class ShopViewController: UIViewController {
    typealias ViewModel = ShopViewModel
    typealias Section = ViewModel.Section
    private let viewModel = ViewModel()

    private lazy var categoryCell = customView.categoryCell
    private lazy var tableView = customView.tableView
    private lazy var itemCell = customView.itemCell
    private lazy var footerView = customView.footerView

    // MARK: View switching
    
    private lazy var customView = ShopView()
    
    override func loadView() {
        view = customView
        setup()
        viewModel.fetchFeed()
    }
    
    // MARK: Setup
    
    private func setup() {
        setupNavigationBar()
        tableView.delegate = self
        tableView.dataSource = self
        setupBind()
    }
 
    private func setupNavigationBar() {
        let navBar = navigationController?.navigationBar
        navBar?.barTintColor = .white
        navBar?.isTranslucent = false
        navBar?.setValue(true, forKey: "hidesShadow")
        navBar?.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        title = ViewModel.navTitle
    }
    
    private func setupBind() {
        
        viewModel.feed.bind { [weak self] feed in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.error.bind { [weak self] error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                let alert = UIAlertController(
                    title: "Error",
                    message: error?.localizedDescription,
                    doneButtonTitle: "OK"
                ) { action in
                    self.dismiss(animated: true)
                }
                self.present(alert, animated: true)
            }
        }
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
                let curIndex = itemCell.currentIndexPath
                let items = viewModel.products?[safe: curIndex.row]?.items
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
        return CGFloat(viewModel.heightForHeaderInSection(section))
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == Section.notice.rawValue {
            return footerView.frame.height
        }
        return CGFloat(viewModel.heightForFooterInSection(section))
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        func createLabel(with text: String) -> UILabel {
            let label = UILabel(color: .white)
            label.text = "     \(text)"
            return label
        }
        switch section {
        case Section.product.rawValue:
            return createLabel(with: ViewModel.productSectionTitle)
        case Section.recent.rawValue:
            return createLabel(with: ViewModel.recentSectionTitle)
        case Section.notice.rawValue:
            return createLabel(with: ViewModel.noticeSectionTitle)
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == Section.notice.rawValue {
            footerView.delegate = self
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
                categoryCell.delegate = self
                categoryCell.configure(products: viewModel.products)
                return categoryCell
            case Section.ProductRow.item.rawValue:
                itemCell.delegate = self
                itemCell.configure(products: viewModel.products)
                return itemCell
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
        itemCell.select(at: index)
        updateTableView()
    }
    private func updateTableView() {
        UIView.animate(withDuration: 0) {
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
    }
}

extension ShopViewController: CategoryItemsTableViewCellDelegate {
    func didScroll(_ sender: CategoryItemsTableViewCell, to index: Int) {
        categoryCell.select(at: index)
        updateTableView()
    }
}

extension ShopViewController: CompanyFooterViewDelegate {
    func didTapExpandButton(_ sender: CompanyFooterView) {
        sender.updateHeight(isShrink: !sender.isShrink)
        tableView.reloadData()
    }
}
