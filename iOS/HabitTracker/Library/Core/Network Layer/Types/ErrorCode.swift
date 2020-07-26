//
//  ErrorCode.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 7/23/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation

enum ErrorCode: CustomStringConvertible {
    
    case jsonMapping
    case statusCode(Int)
    case data
    case networkFailure
    
    var intValue: Int {
        switch self {
        case .jsonMapping: return 0
        case let .statusCode(code): return code
        case .data: return 1
        case .networkFailure: return 2
        }
    }
    
    var description: String {
        switch self {
        case .jsonMapping:
            return "JSON mapping"
        default:
            return "Unknown mapping"
        }
    }
    
}
