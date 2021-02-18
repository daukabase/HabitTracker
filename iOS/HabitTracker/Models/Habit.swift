//
//  Habit.swift
//  HabitTracker
//
//  Created by Daulet on 4/25/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit


class Habit {
    
    static let empty = Habit(id: "",
                             title: "",
                             notes: "",
                             durationDays: 0,
                             startDate: Date(),
                             schedule: [],
                             color: UIColor.clear,
                             isCurrentCompleted: false,
                             habitIcon: .apple,
                             goal: (0, 0))
    
    let id: String
    let title: String
    let notes: String
    let startDate: Date
    let schedule: Set<Day>
    let colorHex: String
    var isCurrentCompleted: Bool
    let habitIcon: HabitIcon
    let durationDays: Int
    var checkpoint: CheckpointModel?
    
    private(set) var totalRepetitions: Int = 0
    private(set) var completedRepetitions: Int = 0
    
    var image: UIImage {
        return habitIcon.icon
    }
    
    var color: UIColor {
        return UIColor(hexString: colorHex)
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
    
    convenience init?(habit: HabitModel, checkpoint: CheckpointModel?) {
        guard
            case let Frequency.weekly(days) = habit.frequence
        else {
            return nil
        }
        self.init(id: habit.id,
                  title: habit.title,
                  notes: habit.notes,
                  durationDays: habit.durationDays,
                  startDate: habit.startDate,
                  schedule: days,
                  colorHex: habit.colorHex,
                  isCurrentCompleted: checkpoint?.isDone ?? false,
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

extension Habit: Equatable, Hashable {
    
    // MARK: - Equatable & Hashable
    static func ==(lhs: Habit, rhs: Habit) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
