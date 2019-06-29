//
//  NetworkManager.swift
//  BaseProject
//
//  Created by dongseok lee on 15/06/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import Foundation

class NetworkManager {
    
    // MARK: Error
    
    enum ErrorCode: Int {
        case urlError = 1
        case responseError
        case dataError
        case jsonEncodingError
    }
    
    static let errorDomain = "app.network"
    static func error(with code: ErrorCode) -> NSError {
        return NSError(domain: errorDomain, code: code.rawValue, userInfo: nil)
    }
    
    // MARK: Header
    
    static let header: [String: String] = [
        "Content-Type": "application/json"
    ]
    
    enum RequestType {
        case post
        case get
        
        var httpMethod: String {
            switch self {
            case .post: return "POST"
            case .get: return "GET"
            }
        }
    }
    
    // MARK: Request
    
    typealias DataResult = Result<Data, Error>
    typealias DataResultHandler = (DataResult) -> Void
    
    func request(
        by urlString: String,
        type: RequestType,
        handler: @escaping DataResultHandler) {
        let url = URL(string: urlString)
        request(by: url, type: type, handler: handler)
    }
    func request(
        by url: URL?,
        type: RequestType,
        handler: @escaping DataResultHandler) {
        
        guard let url = url else {
            handler(.failure(NetworkManager.error(with: .urlError)))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = type.httpMethod
        request.allHTTPHeaderFields = NetworkManager.header
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) {
            (responseData, response, responseError) in
            
            guard responseError == nil else {
                handler(.failure(NetworkManager.error(with: .responseError)))
                return
            }
            guard let data = responseData else {
                handler(.failure(NetworkManager.error(with: .dataError)))
                return
            }
            handler(.success(data))
        }
        task.resume()
    }
    
    // MARK: Handler
    struct ResultType<Type: Decodable> {
        static func handle(
            _ result: DataResult,
            handler: @escaping (Result<Type, Error>) -> Void) {
            
            switch result {
            case .success(let value):
                let decoder = JSONDecoder()
                guard let model = try? decoder.decode(Type.self, from: value) else {
                    handler(.failure(NetworkManager.error(with: .jsonEncodingError)))
                    return
                }
                handler(.success(model))
                
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
}

