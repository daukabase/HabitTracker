//
//  HabitStorage+Achievement.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 10/7/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation

protocol AchievementStorageAbstract {
    static func getAchievements(for habitId: String, completion: Closure<RResult<[AchievementDTO]>>)
    static func getNewAchievement(for habitId: String, completion: Closure<RResult<AchievementDTO?>>)
}

extension HabitStorage: AchievementStorageAbstract {
    
    static func getAchievements(for habitId: String, completion: (RResult<[AchievementDTO]>) -> Void) {
        fatalError("not implemented")
    }
    
    static func getNewAchievement(for habitId: String, completion: (RResult<AchievementDTO?>) -> Void) {
        fatalError("not implemented")
    }
    
}