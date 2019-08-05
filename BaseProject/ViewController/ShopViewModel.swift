//
//  ShopViewModel.swift
//  BaseProject
//
//  Created by dongseok lee on 15/06/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import Foundation

final class ShopViewModel {
    
    enum Section: Int, CaseIterable {
        case banner = 0
        case product
        case recent
        case notice
        
        enum ProductRow: Int {
            case category
            case item
        }
    }
    
    static let productSectionTitle = "Product"
    static let recentSectionTitle = "Recently Viewed"
    static let noticeSectionTitle = "Notice"
    static let numOfMaxItem = 6
    static let bottomInset = 100

    // MARK: Data
    
    var feed = Binding<ShopResponseModel>()
    
    var banners: [BannerModel]? {
        return feed.value?.banners
    }
    var products: [ProductModel]? {
        return feed.value?.products
    }
    var recents: [ItemModel]? {
        return feed.value?.recents
    }
    var notices: [NoticeModel]? {
        return feed.value?.notices
    }
    func notice(at index: Int) -> NoticeModel? {
        return notices?[safe: index]
    }

    // MARK: TableView
    
    let numberOfSection = Section.allCases.count
    func numberOfRowsInSection(_ section: Int) -> Int {
        switch section {
        case Section.banner.rawValue:
            return (banners?.count ?? 0) > 0 ? 1 : 0
        case Section.product.rawValue:
            return (products?.count ?? 0) > 0 ? 2 : 0
        case Section.recent.rawValue:
            return (recents?.count ?? 0) > 0 ? 1 : 0
        case Section.notice.rawValue:
            return notices?.count ?? 0
        default:
            return 0
        }
    }
    
    func heightForHeaderInSection(_ section: Int) -> Float {
        switch section {
        case Section.product.rawValue: return 60
        case Section.recent.rawValue: return 60
        case Section.notice.rawValue: return 60
        default:
            return 0
        }
    }
    
    func heightForFooterInSection(_ section: Int) -> Float {
        switch section {
        case Section.banner.rawValue: return 10
        case Section.product.rawValue: return 10
        case Section.recent.rawValue: return 10
        default:
            return 0
        }
    }
 
    // MARK: API
    func fetchFeed() {
        API.shared.requestFeed { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                print(value)
                self.feed.value = value
            case .failure(let error):
                print(error)
            }
        }
    }
}
