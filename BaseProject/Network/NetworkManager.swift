//
//  NetworkManager.swift
//  BaseProject
//
//  Created by dongseok lee on 15/06/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import Foundation

typealias NetworkError = NetworkManager.CustomError

class NetworkManager {
    
    enum CustomError: Error {
        case url
        case response(error: Error?)
        case data
        case jsonDecoding(error: Error?)
        
        static let domain = "app.network"
    }

    static let header: [String: String] = [
        "Content-Type": "application/json"
    ]
    
    // MARK: Request
    
    enum RequestType: String {
        case post = "POST"
        case get = "GET"
        
        var httpMethod: String {
            return self.rawValue
        }
    }
    
    typealias DataResult = Result<Data, NetworkError>
    typealias DataResultHandler = (DataResult) -> Void
    
    func request(
        with url: URL,
        type: RequestType,
        body: String? = nil,
        handler: @escaping DataResultHandler) {
        
        var req = URLRequest(url: url)
        req.httpMethod = type.httpMethod
        req.allHTTPHeaderFields = NetworkManager.header
        req.httpBody = body?.data(using: .utf8) ?? nil
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)

        request(with: session, req, handler)
    }
    
    func request(
        with session: URLSession,
        _ request: URLRequest,
        _ handler: @escaping DataResultHandler) {
        
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
    
    // MARK: Decoder
    struct ResponseType<Type: Decodable> {
        static func decodeResult(
            _ result: DataResult,
            handler: @escaping (Result<Type, NetworkError>) -> Void) {
            
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let value = try decoder.decode(Type.self, from: data)
                    handler(.success(value))
                } catch {
                    handler(.failure(.jsonDecoding(error: error)))
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
        body: String? = nil,
        handler: @escaping DataResultHandler) {
        guard let url = URL(string: urlString) else {
            handler(.failure(.url))
            return
        }
        request(with: url, type: type, body: body, handler: handler)
    }
}
