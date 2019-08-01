//
//  ShopResponseModel.swift
//  BaseProject
//
//  Created by leedongseok on 14/06/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import Foundation

struct ShopResponseModel: Codable {
    let banners: [BannerModel]
    let products: [ProductModel]
    let recents: [ItemModel]
    let notices: [NoticeModel]
}

struct BannerModel: Codable {
    let image: String
    let title: String
    let sub_title: String
}

struct ProductModel: Codable {
    let category_name: String
    let items: [ItemModel]
}

struct ItemModel: Codable {
    let image: String
    let title: String
}

struct NoticeModel: Codable {
    let title: String
    let date: String
}
