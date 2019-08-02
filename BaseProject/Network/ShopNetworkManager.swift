//
//  ShopNetworkManager.swift
//  BaseProject
//
//  Created by leedongseok on 14/06/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import Foundation

final class ShopNetworkManager: NetworkManager {
    static let shared = ShopNetworkManager()
    
    struct URL {
        static let base = "http://api.goodeffect.com:11000/"
    }
}

// MARK: Interface
extension ShopNetworkManager {
    typealias ShopResultHandler = (Result<ShopResponseModel, NetworkError>) -> Void

    func requestFeed(
        handler: @escaping ShopResultHandler) {
        
        let expectedResponse = DataBuilder.build()

        let encoder = JSONEncoder()
        let data = try! encoder.encode(expectedResponse)
        let body = String(bytes: data, encoding: .utf8)!

        request(
            with: ShopNetworkManager.URL.base,
            type: .post,
            body: body) { result in
                ResponseType<ShopResponseModel>
                    .decodeResult(result, handler: handler)
        }
    }
}
