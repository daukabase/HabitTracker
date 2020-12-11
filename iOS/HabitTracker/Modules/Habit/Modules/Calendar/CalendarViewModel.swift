//
//  CalendarViewModel.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 12/12/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

struct CalendarViewModel {
    
    private var dateCheckpointMap: [Date: CheckpointModel] = [:]
    
    let startDate: Date
    let endDate: Date
    let selectedDates: [Date]
    let themeColor: UIColor
    let dateFormatter = Formatter.MMMyyyy
    
    func isDone(for date: Date) -> Bool {
        guard let checkpoint = dateCheckpointMap[date] else {
            return false
        }
        return checkpoint.isDone
    }
    
    func isMissed(date: Date) -> Bool {
        return dateCheckpointMap[date]?.isMissed ?? false
    }
    
    init(checkpoints: [CheckpointModel], color: UIColor) {
        let dates = checkpoints
            .filter { checkpoint in
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
            dateCheckpointMap[checkpoint.date] = checkpoint
        }
    }
    
}
