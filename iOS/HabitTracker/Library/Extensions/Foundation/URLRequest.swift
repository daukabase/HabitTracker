//
//  URLRequest.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 7/22/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation

public extension URLRequest {
    
    mutating func add(headers: [Header]) {
        headers.forEach { (header) in
            addValue(header.value, forHTTPHeaderField: header.key)
        }
    }
    
}
