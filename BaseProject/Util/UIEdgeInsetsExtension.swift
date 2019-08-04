//
//  UIEdgeInsetsExtension.swift
//  BaseProject
//
//  Created by leedongseok on 04/08/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import UIKit

extension UIEdgeInsets {
    init(side: CGFloat) {
        self.init(top: 0, left: side, bottom: 0, right: side)
    }
}
