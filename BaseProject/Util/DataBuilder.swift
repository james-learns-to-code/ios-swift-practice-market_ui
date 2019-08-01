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
        let banners = (0...4).map { index in
            BannerModel(image: getRandomImageURL(), title: "Title \(index + 1)", sub_title: "Sub Title \(index + 1)")
        }
        let products = (0...4).map { categoryIndex -> ProductModel in
            let items = (0...10).map { index in
                ItemModel(image: getRandomImageURL(), title: "Category \(categoryIndex + 1) Item \(index + 1)")
            }
            let product = ProductModel(category_name: "Category \(categoryIndex + 1)", items: items)
            return product
        }
        let recents = (0...4).map { index in
            ItemModel(image: getRandomImageURL(), title: "Recent Item \(index + 1)")
        }
        let notices = (0...3).map { index in
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
    
    private static func getRandomImageURL() -> String {
        return imageUrls[Int.random(in: 0..<imageUrls.count)]
    }
    
    private static func getRandomDate() -> Date {
        return Date.init(timeIntervalSince1970: TimeInterval(Int.random(in: 0...100000)))
    }
}
