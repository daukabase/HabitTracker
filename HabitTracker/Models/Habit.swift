//
//  Habit.swift
//  HabitTracker
//
//  Created by Daulet on 4/25/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

class Habit {
    
    var title: String
    var notes: String
    var startDate: Date
    var schedule: Set<Day>
    var colorHex: String
    var isCurrentCompleted: Bool
    var image: UIImage?
    
    // TODO: remove mocks
    let totalRepetitions: Int = Int.random(in: 19...24)
    var completedRepetitions = Int.random(in: 7...13)
    
    private var durationDays: Int
    
    var completionAttributedText: NSAttributedString {
        let indicatorValue = NSMutableAttributedString()
        
        let first: [StringAttribute] = [
            .font(FontFamily.Gilroy.semibold.font(size: 18)),
            .foregroundColor(color)
        ]
        let second: [StringAttribute] = [
            .font(FontFamily.Gilroy.regular.font(size: 12)),
            .foregroundColor(color)
        ]
        
        let firstText = "\(completedRepetitions)".with(attributes: first)
        let secondText = "/\(totalRepetitions)".with(attributes: second)
        
        [firstText, secondText].forEach(indicatorValue.append)
        
        return  indicatorValue
    }
    
    var daysLeft: Int {
        return 4
    }
    
    var color: UIColor {
        return UIColor(hexString: colorHex)
    }
    
    var progress: Float {
        guard totalRepetitions != 0 else {
            return 0
        }
        return Float(completedRepetitions) / Float(totalRepetitions)
    }
    
    func done() {
        completedRepetitions += 1
        isCurrentCompleted = true
    }
    
    func undone() {
        completedRepetitions -= 1
        isCurrentCompleted = false
    }
    
    init(title: String,
         notes: String,
         durationDays: Int,
         startDate: Date,
         schedule: [Day],
         color: UIColor,
         isCurrentCompleted: Bool,
         image: UIImage?) {
        
        self.title = title
        self.notes = notes
        self.durationDays = durationDays
        self.startDate = startDate
        self.schedule = Set(schedule)
        self.colorHex = color.toHexString()
        self.isCurrentCompleted = isCurrentCompleted
        self.image = image
    }
    
    init(title: String,
         notes: String,
         durationDays: Int,
         startDate: Date,
         schedule: [Day],
         colorHex: String,
         isCurrentCompleted: Bool,
         image: UIImage?) {
        self.title = title
        self.notes = notes
        self.durationDays = durationDays
        self.startDate = startDate
        self.schedule = Set(schedule)
        self.colorHex = colorHex
        self.isCurrentCompleted = isCurrentCompleted
        self.image = image
    }
    
}
