//
//  Bindeable.swift
//  BaseProject
//
//  Created by dongseok lee on 15/06/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import Foundation

protocol Bindable {
    associatedtype T
    var value: T? { get set }
    mutating func bind(closure: ((T?) -> Void)?)
}

final class PropertyBindable<Type>: Bindable {
    private var closure: ((Type?) -> Void)?
    
    var value: Type? {
        didSet { closure?(value) }
    }
    
    // DO NOT set 'value' in 'closure'. It will drag to recursive situtation.
    func bind(closure: ((Type?) -> Void)?) {
        self.closure = closure
    }
}
