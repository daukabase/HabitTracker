//
//  Days.swift
//  HabitTracker
//
//  Created by Daulet on 4/25/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation

enum Day: Int, CaseIterable {
    case monday = 0
    case tuesday, wednesday, thursday, friday, saturday, sunday
}

extension Day {
    
    var title: String {
        switch self {
        case .monday:
            return "M"
        case .tuesday:
            return "T"
        case .wednesday:
            return "W"
        case .thursday:
            return "T"
        case .friday:
            return "F"
        case .saturday:
            return "S"
        case .sunday:
            return "S"
        }
    }
    
    func isIn(_ date: Date) -> Bool {
        // return range from 1 to 7
        let indexOfDay = Calendar.current.component(.weekday, from: date) - 1
        return self.rawValue == indexOfDay
    }
    
}
