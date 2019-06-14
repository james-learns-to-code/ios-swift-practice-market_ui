//
//  StarwarsViewController.swift
//  BaseProject
//
//  Created by leedongseok on 14/06/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import UIKit

final class StarwarsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        StarwarsNetworkManager.shared.requestApiList { [weak self] result in
            switch result {
            case .success(let value):
                print(value)
            case .failure(let error):
                print(error)
            }
        }
    }
}
