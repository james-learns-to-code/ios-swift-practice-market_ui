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
    
    struct URL {
        static let base = "http://api.goodeffect.com:11000/"
        static let filmPath = "films/"
        static let film = base + filmPath
    }
}

// MARK: Interface
extension StarwarsNetworkManager {
    typealias FilmListResultHandler = (Result<StarwarsFilmsModel, NetworkError>) -> Void

    func requestFilmList(
        handler: @escaping FilmListResultHandler) {
        
        let film = StarwarsFilmModel(title: "Power", episode_id: 3, director: "James")
        let film2 = StarwarsFilmModel(title: "Wise", episode_id: 2, director: "Horse")
        let films = [film, film2]
        let expectedResponse = StarwarsFilmsModel(results: films)

        let encoder = JSONEncoder()
        let data = try! encoder.encode(expectedResponse)
        let body = String(bytes: data, encoding: .utf8)!
        
        request(
            with: StarwarsNetworkManager.URL.film,
            type: .post,
            body: body) { result in
                ResponseType<StarwarsFilmsModel>
                    .decodeResult(result, handler: handler)
        }
    }
}
