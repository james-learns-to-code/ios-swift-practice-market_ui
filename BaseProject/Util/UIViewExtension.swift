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
            subview.heightAnchor.constraint(equalTo: heightAnchor),
            subview.widthAnchor.constraint(equalTo: widthAnchor),
            subview.centerXAnchor.constraint(equalTo: centerXAnchor),
            subview.centerYAnchor.constraint(equalTo: centerYAnchor),
            ])
    }
}
