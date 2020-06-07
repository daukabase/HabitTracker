//
//  String.swift
//  HabitTracker
//
//  Created by Daulet on 4/26/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation

extension String {
    
    func date(with formatter: DateFormatter) -> Date? {
        return formatter.date(from: self)
    }
    
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
    
}
