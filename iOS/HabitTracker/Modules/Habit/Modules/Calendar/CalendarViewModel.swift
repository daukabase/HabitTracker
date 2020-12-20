//
//  CalendarViewModel.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 12/12/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

struct CalendarViewModel {
    
    private var dateCheckpointMap: [DateDayKey: CheckpointModel] = [:]
    
    let startDate: Date
    let endDate: Date
    let selectedDates: [Date]
    let themeColor: UIColor
    let dateFormatter = Formatter.MMMyyyy
    
    func isDone(for date: Date) -> Bool {
        let key = DateDayKey(date: date)
        guard let checkpoint = dateCheckpointMap[key] else {
            return false
        }
        return checkpoint.isDone
    }
    
    func isMissed(date: Date) -> Bool {
        let key = DateDayKey(date: date)
        return dateCheckpointMap[key]?.isMissed ?? false
    }
    
    init(checkpoints: [CheckpointModel], color: UIColor) {
        let dates = checkpoints
            .filter { checkpoint in
                if checkpoint.isMissed {
                    return false
                }
                // In selected ranges there are must be ONLY done/today/todo checkpoints
                return checkpoint.isDone || checkpoint.isToday || checkpoint.date > Date()
            }
            .compactMap {
                $0.date
            }
        
        self.selectedDates = dates
        self.startDate = dates.min() ?? Date()
        self.endDate = dates.max() ?? Date()
        self.themeColor = color
        
        checkpoints.forEach { checkpoint in
            dateCheckpointMap[DateDayKey(date: checkpoint.date)] = checkpoint
        }
    }
    
}

private extension CalendarViewModel {
    
    struct DateDayKey: Hashable {
        
        private let dateString: String
        
        init(date: Date) {
            self.dateString = date.string(with: .ddMMYYYY)
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(dateString)
        }
        
        static func ==(lhs: DateDayKey, rhs: DateDayKey) -> Bool {
            return lhs.dateString == rhs.dateString
        }
        
    }

}
