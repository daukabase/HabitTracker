//
//  Habit.swift
//  HabitTracker
//
//  Created by Daulet on 4/25/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit


class Habit {
    
    let id: String
    var title: String
    var notes: String
    var startDate: Date
    var schedule: Set<Day>
    var colorHex: String
    var isCurrentCompleted: Bool
    var habitIcon: HabitIcon
    var checkpoint: CheckpointModel?
    
    var image: UIImage {
        return habitIcon.icon
    }
    
    // TODO: remove mocks
    var totalRepetitions: Int = 0
    var completedRepetitions: Int = 0
    
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
    
    init(id: String,
         title: String,
         notes: String,
         durationDays: Int,
         startDate: Date,
         schedule: [Day],
         colorHex: String,
         isCurrentCompleted: Bool,
         habitIcon: HabitIcon,
         goal: HabitGoal) {
        self.id = id
        self.title = title
        self.notes = notes
        self.durationDays = durationDays
        self.startDate = startDate
        self.schedule = Set(schedule)
        self.colorHex = colorHex
        self.isCurrentCompleted = isCurrentCompleted
        self.habitIcon = habitIcon
        self.totalRepetitions = goal.total
        self.completedRepetitions = goal.done
    }
    
    convenience init(id: String,
         title: String,
         notes: String,
         durationDays: Int,
         startDate: Date,
         schedule: [Day],
         color: UIColor,
         isCurrentCompleted: Bool,
         habitIcon: HabitIcon,
         goal: HabitGoal) {
        self.init(id: id,
                  title: title,
                    notes: notes,
                    durationDays: durationDays,
                    startDate: startDate,
                    schedule: schedule,
                    colorHex: color.toHexString(),
                    isCurrentCompleted: isCurrentCompleted,
                    habitIcon: habitIcon,
                    goal: goal)
    }
    
    convenience init?(habit: HabitModel, checkpoint: CheckpointModel) {
        guard
            case let Frequency.weekly(days) = habit.frequence,
            let startDate = habit.startDate.date(with: .storingFormat)
        else {
            return nil
        }
        self.init(id: habit.id,
                  title: habit.title,
                  notes: habit.notes,
                  durationDays: habit.durationDays,
                  startDate: startDate,
                  schedule: days,
                  colorHex: habit.colorHex,
                  isCurrentCompleted: checkpoint.isDone,
                  habitIcon: habit.icon,
                  goal: (0, 0))
        
        self.checkpoint = checkpoint
    }
    
    func updateGoal(completion: EmptyClosure?) {
        AchievementsRepository.shared.getGoal(for: id) { (result) in
            defer {
                completion?()
            }
            guard let goal = result.value else {
                return
            }
            self.completedRepetitions = goal.done
            self.totalRepetitions = goal.total
        }
    }
    
}
