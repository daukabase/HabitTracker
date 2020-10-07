//
//  Checkpoint.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 10/7/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation

class Checkpoint {
    let date: Date
    let isDone: Bool
    
    init(date: Date, isDone: Bool) {
        self.date = date
        self.isDone = isDone
    }
}

