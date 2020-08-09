//
//  Collection.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 7/23/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation

public extension Dictionary where Key == String {
    
    subscript(dict key: String) -> Dictionary? {
        return self[key] as? Dictionary
    }
    
    subscript<T>(_ key: String, type: T.Type) -> T? {
        return self[key] as? T
    }
    
}

