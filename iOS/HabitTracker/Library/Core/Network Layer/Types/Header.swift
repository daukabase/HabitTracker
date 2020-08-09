//
//  Header.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 7/22/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation

public enum Header {
    typealias HeaderData = (key: String, value: String)
    
    case authorization(token: String)
    case content(type: String)
    case custom(key: String, value: String)
    
    public var key: String {
        return args.key
    }
    
    public var value: String {
        return args.value
    }
    
    private var args: HeaderData {
        switch self {
        case let .authorization(token):
            return (key: "Authorization", value: "Bearer \(token)")
        case let .content(type):
            return (key: "Content-Type", value: type)
        case let .custom(key, value):
            return (key: key, value: value)
        }
    }
    
}
