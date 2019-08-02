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
    
    private var loadDict = [Int: Any]()
    
    func loaderForImageView(_ imageView: UIImageView) -> UIImageViewLoader {
        let hash = imageView.hashValue
        if let loader = loadDict[hash] {
            return loader as! UIImageViewLoader
        }
        let loader = UIImageViewLoader(imageView: imageView)
        if loadDict.count > 100 {
            loadDict.remove(at: loadDict.startIndex)
        }
        loadDict[hash] = loader
        return loader
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
        guard let urlString = urlString, let url = URL(string: urlString) else { return }
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
        return (task?.currentRequest?.url == url)
    }
}
