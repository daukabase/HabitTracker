//
//  Date.swift
//  KhanTest
//
//  Created by Daulet on 14/09/2019.
//  Copyright © 2019 daukabase. All rights reserved.
//

import Foundation

extension Date {
    
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    var daySerialized: Date {
        return Date(milliseconds: millisRemovedMinor)
    }
    
    var isToday: Bool {
        return isSameDay(with: Date())
    }
    
    var day: Day {
        let indexOfDay = Calendar.current.component(.weekday, from: self) - 1
        
        guard let day = Day(rawValue: indexOfDay) else {
            assertionFailure("It always should be initialized")
            return .friday
        }
        
        return day
    }
    
    /// Removes seconds minutes hours
    private var millisRemovedMinor: Int64 {
        return millisecondsSince1970 - (millisecondsSince1970 % (1000 * 3600 * 24))
    }
    
    init(milliseconds: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }

    static func dates(from fromDate: Date, to toDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = fromDate

        while date <= toDate {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }
        return dates
    }
    
    func string(with formatter: DateFormatter) -> String {
        return formatter.string(from: self)
    }
    
    func isSameDay(with date: Date) -> Bool {
        return self.millisRemovedMinor == date.millisRemovedMinor
    }
    
    func byDaySerialized(with date: Date, by component: Calendar.Component) -> Bool {
        let days1 = Calendar.current.component(component, from: self)
        let days2 = Calendar.current.component(component, from: date)
        
        return days1 == days2
    }
    
}
