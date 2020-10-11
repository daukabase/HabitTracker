//
//  Result.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 7/23/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation

typealias RResult<T> = Result<T, Error>

public extension Result {
    
    var success: Success? {
        switch self {
        case let .success(value):
            return value
        case .failure:
            return nil
        }
    }
    
    var value: Success? {
        return success
    }
    
    var failure: Failure? {
        switch self {
        case .success:
            return nil
        case let .failure(value):
            return value
        }
    }
    
    var error: Failure? {
        return failure
    }
    
    var isSucceed: Bool {
        return success != nil
    }
    
    var isError: Bool {
        return failure != nil
    }
    
}
