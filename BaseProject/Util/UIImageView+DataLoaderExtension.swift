//
//  UIImageView+DataLoaderExtension.swift
//  BaseProject
//
//  Created by leedongseok on 01/08/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import UIKit

extension UIImageView {
    var loader: UIImageViewLoader {
        return DataLoader.shared.loaderForImageView(self)
    }
}
