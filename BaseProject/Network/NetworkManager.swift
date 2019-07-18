//
//  NetworkManager.swift
//  BaseProject
//
//  Created by dongseok lee on 15/06/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case url
    case response(error: Error?)
    case data
    case jsonEncoding(error: Error?)
    
    static let domain = "app.network"
}

class NetworkManager {
    
    static let header: [String: String] = [
        "Content-Type": "application/json"
    ]
    
    // MARK: Request
    
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
    
    typealias DataResult = Result<Data, NetworkError>
    typealias DataResultHandler = (DataResult) -> Void
    
    func request(
        with url: URL?,
        type: RequestType,
        handler: @escaping DataResultHandler) {
        
        guard let url = url else {
            handler(.failure(.url))
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
                handler(.failure(.response(error: responseError)))
                return
            }
            guard let data = responseData else {
                handler(.failure(.data))
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
            handler: @escaping (Result<Type, NetworkError>) -> Void) {
            
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let value = try decoder.decode(Type.self, from: data)
                    handler(.success(value))
                } catch {
                    handler(.failure(.jsonEncoding(error: error)))
                }
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
}

// MARK: Interface
extension NetworkManager {
    func request(
        with urlString: String,
        type: RequestType,
        handler: @escaping DataResultHandler) {
        let url = URL(string: urlString)
        request(with: url, type: type, handler: handler)
    }
}
