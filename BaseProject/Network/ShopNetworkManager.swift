//
//  ShopNetworkManager.swift
//  BaseProject
//
//  Created by leedongseok on 14/06/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import Foundation

typealias API = ShopNetworkManager

final class ShopNetworkManager: NetworkManager {
    static let shared = ShopNetworkManager()
    
    struct URL {
        static let base = "http://api.goodeffect.com:11000/"
    }
}

// MARK: Interface
extension ShopNetworkManager {
    typealias ShopResultHandler = (Result<ShopResponseModel, NetworkError>) -> Void

    private var shopRequestExpectedResponse: String {
        let expectedResponse = DataBuilder.build()
        let encoder = JSONEncoder()
        let data = try! encoder.encode(expectedResponse)
        let str = String(bytes: data, encoding: .utf8)!
        return str
    }
    
    func requestFeed(
        handler: @escaping ShopResultHandler) {
        request(
            with: ShopNetworkManager.URL.base,
            type: .post,
            body: shopRequestExpectedResponse) { result in
                ResponseType<ShopResponseModel>
                    .decodeResult(result, handler: handler)
        }
    }
}
