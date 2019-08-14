//
//  DataLoader.swift
//  BaseProject
//
//  Created by leedongseok on 02/08/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import UIKit

final class DataLoader {
    static var shared = DataLoader()
    
    typealias LoadDictType = [Int: UIImageViewLoader]
    private var loadDict = LoadDictType()
    
    private let dictCount = 100
    
    func loaderForImageView(_ imageView: UIImageView) -> UIImageViewLoader {
        let hash = imageView.hashValue
        if let loader = loadDict[hash] {
            return loader
        }
        removeFirstIn(&loadDict, ifExceed: dictCount)
        let loader = UIImageViewLoader(imageView: imageView)
        loadDict[hash] = loader
        return loader
    }
    private func removeFirstIn(_ dict: inout LoadDictType, ifExceed count: Int) {
        guard dict.count > count else { return }
        dict.remove(at: dict.startIndex)
    }
}

final class UIImageViewLoader {
    
    convenience init(imageView: UIImageView) {
        self.init()
        self.imageView = imageView
    }
    
    private weak var imageView: UIImageView?
    private var task: URLSessionTask?
    
    func setImageWithUrlString(_ urlString: String?) {
        guard let urlString = urlString else { return }
        let url = URL(string: urlString)
        setImageWithUrl(url)
    }
    
    func setImageWithUrl(_ url: URL?) {
        guard let url = url else { return }
        guard isAlreadyRequesting(url: url) == false else { return }
        task?.cancel()
        let request = URLRequest(url: url)
        task = send(request)
        task?.resume()
    }
    
    private func send(_ request: URLRequest) -> URLSessionTask {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        return session.dataTask(with: request) {
            [weak self] (data, response, error) in
            guard let data = data else { return }
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                self?.imageView?.image = image
            }
        }
    }
    
    private func isAlreadyRequesting(url: URL) -> Bool {
        let curUrl = task?.currentRequest?.url
        return curUrl == url
    }
}
