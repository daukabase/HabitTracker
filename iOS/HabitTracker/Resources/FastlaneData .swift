//
//  FastlaneData .swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 2/14/21.
//  Copyright © 2021 Daulet. All rights reserved.
//

import Foundation

public enum FastlaneData {
    public enum TestData {
        private static let _goal = HabitGoal(done: 4, total: 21)
        
        enum Checkpoints {
            static let startDate = Calendar.current.date(byAdding: .day, value: -4, to: Date())!
            
            static let checkpoints = (1...21).compactMap { value -> CheckpointModel? in
                guard let date = Calendar.current.date(byAdding: .day, value: value, to: startDate) else {
                    return nil
                }
                let isDone = (!date.isToday && date < Date()) || date.isToday
                
                return CheckpointModel(id: "\(value)", habitId: "run", date: date, isDone: isDone)
                
            }
        }
        
        enum Achievements {
            static let testData = [longestStreak, currentStreak, total, goal]
            
            static let goal = GoalAchievement(completedDays: _goal.done, totalDays: _goal.total)
            static let longestStreak = CommonAchievement.getLongestStreak(for: _goal.done)
            static let currentStreak = CommonAchievement.getCurrentStreak(for: _goal.done)
            static let total = CommonAchievement.getTotalDone(for: _goal.done)
        }
        
        public enum Habits {
            static let testData = [run, drink, meditation]
            public static let run = Habit(id: "run",
                                   title: "Running at 7 am",
                                   notes: "Short run is better than no run",
                                   durationDays: 21,
                                   startDate: Checkpoints.startDate,
                                   schedule: [.monday, .tuesday, .wednesday, .thursday, .friday],
                                   color: HabitColor.habitBlue.color,
                                   isCurrentCompleted: true,
                                   habitIcon: .running,
                                   goal: _goal)
            static let meditation = Habit(id: "run",
                                          title: "Meditation",
                                          notes: "10 minutes of meditation",
                                          durationDays: 66,
                                          startDate: Date(),
                                          schedule: [.monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday],
                                          color: HabitColor.yellow.color,
                                          isCurrentCompleted: false,
                                          habitIcon: .meditation,
                                          goal: (done: 10, total: 14))
            static let drink = Habit(id: "Drink water after lunch",
                                     title: "water is good",
                                     notes: "10 minutes of meditation",
                                     durationDays: 66,
                                     startDate: Date(),
                                     schedule: [.monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday],
                                     color: HabitColor.skyBlue.color,
                                     isCurrentCompleted: true,
                                     habitIcon: .drink,
                                     goal: (done: 10, total: 14))
        }
        
    }
}
