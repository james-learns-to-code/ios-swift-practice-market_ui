//
//  DataBuilder.swift
//  BaseProject
//
//  Created by leedongseok on 31/07/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import Foundation

struct DataBuilder {
    
    static func build() -> ShopResponseModel {
        let bannerCount = 4
        let productCount = 8
        let itemMaxCount = 10
        let recentCount = 4
        let noticeCount = 3
        
        let banners = (0...bannerCount).map { index in
            BannerModel(image: getRandomImageURL(), title: "Title \(index + 1)", sub_title: "Sub Title \(index + 1)")
        }
        let products = (0...productCount).map { categoryIndex -> ProductModel in
            let randomItemCount = Int.random(in: 0...itemMaxCount)
            let items = (0...randomItemCount).map { index in
                ItemModel(image: getRandomImageURL(), title: "Category \(categoryIndex + 1) Item \(index + 1)", promotion: getPromotionName(), price: getRandomPrice())
            }
            let product = ProductModel(category_name: getRandomCategoryName(), items: items)
            return product
        }
        let recents = (0...recentCount).map { index in
            ItemModel(image: getRandomImageURL(), title: "Recent Item \(index + 1)", promotion: "", price: getRandomPrice())
        }
        let notices = (0...noticeCount).map { index in
            NoticeModel(title: "Notice \(index + 1)", date: DateFormatter().string(from: getRandomDate()))
        }
        return ShopResponseModel(
            banners: banners,
            products: products,
            recents: recents,
            notices: notices)
    }
    
    private static let imageUrls: [String] = [
        "https://live.staticflickr.com/65535/48422404217_01ecf6db5a_m.jpg",
        "https://live.staticflickr.com//65535//48422275796_6a7b3ac03d_m.jpg",
        "https://live.staticflickr.com//65535//48422426642_61d6ce73cb_m.jpg",
        "https://live.staticflickr.com//65535//48422229657_8cfc308303_m.jpg",
        "https://live.staticflickr.com//65535//48422256131_5c9c0a06c3_m.jpg",
        "https://live.staticflickr.com//65535//48422062596_95b91e97d9_m.jpg",
        "https://live.staticflickr.com//65535//48422075761_f90e31f638_m.jpg"
    ]
    
    private static let categoryNames: [String] = [
        "NEW",
        "ALBUM",
        "DVD",
        "TICKET",
        "GOODS",
        "POST CARD"
    ]
    
    private static let promotionNames: [String] = [
        "EXCLUSIVE",
        "PRE ORDER",
        "SPECIAL",
        "DISCOUNT"
    ]
    
    private static let prices: [Double] = [
        30.0,
        18.0,
        13.5,
        21.5,
        100.3
    ]
    
    private static func getRandomPrice() -> Double {
        return prices[Int.random(in: 0..<prices.count)]
    }
    
    private static func getPromotionName() -> String {
        return promotionNames[Int.random(in: 0..<promotionNames.count)]
    }
    
    private static func getRandomImageURL() -> String {
        return imageUrls[Int.random(in: 0..<imageUrls.count)]
    }
    
    private static func getRandomDate() -> Date {
        return Date.init(timeIntervalSince1970: TimeInterval(Int.random(in: 0...100000)))
    }
    
    private static func getRandomCategoryName() -> String {
        return categoryNames[Int.random(in: 0..<categoryNames.count)]
    }
}
