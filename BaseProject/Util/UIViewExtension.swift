//
//  UIViewExtension.swift
//  BaseProject
//
//  Created by leedongseok on 01/08/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import UIKit

extension UIView {
    func addSubviewWithFullsize(_ subview: UIView) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: topAnchor),
            subview.bottomAnchor.constraint(equalTo: bottomAnchor),
            subview.leftAnchor.constraint(equalTo: leftAnchor),
            subview.rightAnchor.constraint(equalTo: rightAnchor)
            ])
    }
}

extension UIView {
    convenience init(color: UIColor) {
        self.init()
        backgroundColor = color
    }
}
