//
//  Habit.swift
//  HabitTracker
//
//  Created by Daulet on 4/25/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

struct Habit {
    var title: String
    var notes: String
    var duration: Int
    var startData: Date
    var schedule: Set<Days>
    var image: UIImage?
    
    var daysLeft: Int {
        return 4
    }
    
    var maxRepetitions: Int {
        return 30
    }
    
    var completedRepetitions: Int {
        return 13
    }
    
}
