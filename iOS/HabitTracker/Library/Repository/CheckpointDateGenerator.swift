//
//  CheckpointDateGenerator.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 12/11/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation

final class CheckpointDateGenerator {
    
    private enum Constants {
        static let hourDefault: Int = 0
        static let minuteDefault: Int = 0
    }
    
    let frequency: Frequency
    let startDate: Date
    let durationDays: Int
    let hour: Int
    let minute: Int
    
    init(for frequency: Frequency,
         startDate: Date,
         durationDays: Int,
         checkpointAppearTime: Date?) {
        self.frequency = frequency
        self.startDate = startDate
        self.durationDays = durationDays
        self.hour = checkpointAppearTime?.hour ?? Constants.hourDefault
        self.minute = checkpointAppearTime?.minute ?? Constants.minuteDefault
    }
    
    func generateDatesForCheckpoints() -> [Date] {
        switch frequency {
        case let .weekly(days):
            return generateDatesWeekly(using: Set(days))
        case .daily:
            fatalError("Not available")
        }
    }
    
    private func generateDatesWeekly(using days: Set<Day>) -> [Date] {
        var dates = [Date]()
        
        for dayCount in (0..<self.durationDays) {
            guard var date = Calendar.current.date(byAdding: .day, value: dayCount, to: startDate) else {
                assertionFailure("Something wrong")
                continue
            }
            
            guard needToUse(date: date, for: days) else {
                continue
            }
            
            configure(date: &date)
            dates.append(date)
        }
        
        return dates
    }
    
    private func needToUse(date: Date, for days: Set<Day>) -> Bool {
        let isInSelectedDayRange = days.contains(date.day)
        let isDateInPast = !date.isToday && date < Date()
        
        return isInSelectedDayRange && !isDateInPast
    }
    
    private func configure(date: inout Date) {
        guard let updatedDate = Calendar.current.date(bySettingHour: hour,
                                                      minute: minute,
                                                      second: .zero,
                                                      of: date) else {
            return
        }
        date = updatedDate
    }
    
}
