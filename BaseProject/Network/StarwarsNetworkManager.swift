//
//  StarwarsNetworkManager.swift
//  BaseProject
//
//  Created by leedongseok on 14/06/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import Foundation

final class StarwarsNetworkManager: NetworkManager {
    static let shared = StarwarsNetworkManager()
    
    static private let baseUrl = "https://swapi.co/api/"
    static private let filmPath = "films/"
    static private let filmUrl = baseUrl + filmPath

    // MARK: Interface
    func requestFilmList(
        handler: @escaping (Result<StarwarsFilmsModel, Error>) -> Void) {
        
        let urlString = StarwarsNetworkManager.filmUrl
        let url = URL(string: urlString)
        request(by: url, type: .get) { result in
            Handler<StarwarsFilmsModel>
                .handle(result, handler: handler)
        }
    }
}
