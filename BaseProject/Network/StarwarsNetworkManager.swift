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
    
    static let baseUrl = "https://swapi.co/api/"
    static let filmUrl = "films/"
    
    func requestFilmList(
        handler: @escaping (Result<StarwarsFilmsModel, Error>) -> Void) {
        
        let urlString = StarwarsNetworkManager.baseUrl + StarwarsNetworkManager.filmUrl
        let url = URL(string: urlString)
        sendGetRequest(by: url) { result in
            NetworkResultHandler<StarwarsFilmsModel>
                .handleResult(result, handler: handler)
        }
    }
}
