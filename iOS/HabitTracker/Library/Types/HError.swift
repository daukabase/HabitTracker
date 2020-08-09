//
//   enum HError- Error {     case notAnObject } .swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 7/23/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation

enum HError: Error {
    case notAnObject
    
    var localizedDescription: String {
        switch self {
        case .notAnObject:
            return "Object mapping failed"
        }
    }
    
}
