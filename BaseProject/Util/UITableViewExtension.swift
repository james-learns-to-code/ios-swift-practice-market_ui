//
//  UITableViewExtension.swift
//  BaseProject
//
//  Created by leedongseok on 31/07/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import UIKit

extension UITableView {
    public func register(_ cellClass: AnyClass) {
        register(cellClass, forCellReuseIdentifier: String(describing: cellClass))
    }
}

public protocol UITableViewCellDequeueable {}
public extension UITableViewCellDequeueable where Self: UITableViewCell {
    static func dequeue(from tableView: UITableView, for indexPath: IndexPath? = nil) -> Self? {
        if let indexPath = indexPath {
            return tableView.dequeueReusableCell(withIdentifier: String(describing: self), for: indexPath) as? Self
        }
        return tableView.dequeueReusableCell(withIdentifier: String(describing: self)) as? Self
    }
}

extension UITableViewCell: UITableViewCellDequeueable {}
