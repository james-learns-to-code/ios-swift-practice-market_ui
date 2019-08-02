//
//  ViewController.swift
//  BaseProject
//
//  Created by leedongseok on 12/06/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    func presentVC() {
        let vc = ShopViewController()
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: false, completion: nil)
    }
}
