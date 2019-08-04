//
//  ComparableExtension.swift
//  BaseProject
//
//  Created by leedongseok on 04/08/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import Foundation

extension Comparable {
    
    func minimum(_ value: Self) -> Self {
        return self < value ? value : self
    }
    
    func maximum(_ value: Self) -> Self {
        return self > value ? value : self 
    }
}
