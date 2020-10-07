//
//  HabitModel.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 10/7/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation

class HabitModel {
    let title: String
    let notes: String
    let colorHex: String
    let icon: String
    let startDate: Date
    let durationDays: Int
    
    init(title: String, notes: String, colorHex: String, icon: String, startDate: Date, durationDays: Int) {
        self.title = title
        self.notes = notes
        self.colorHex = colorHex
        self.icon = icon
        self.startDate = startDate
        self.durationDays = durationDays
    }
}
