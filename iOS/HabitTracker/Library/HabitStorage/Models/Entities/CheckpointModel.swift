//
//  CheckpointModel.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 10/12/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation

final class CheckpointModel {
    
    let id: String
    let habitId: String
    // DD.MM.yyyy
    let dateString: String
    let isDone: Bool
    
    var date: Date? {
        return dateString.date(with: .storingFormat)
    }
    
    var notificationId: String {
        return id
    }
    
    var isToday: Bool {
        // This strange logic is used because I don't want to deal with timeZones
        let todayDate = Date().string(with: .storingFormatWithoutMinors)
        
        return dateString.hasPrefix(todayDate)
    }
    
    var isMissed: Bool {
        guard !isToday, !isDone, let date = date else {
            return false
        }
        return date < Date()
    }
    
    init(id: String, habitId: String, date: String, isDone: Bool) {
        self.id = id
        self.habitId = habitId
        self.dateString = date
        self.isDone = isDone
    }
    
}

extension CheckpointModel: DTODecodable {
    
    typealias DTO = CheckpointDTO

    static func from(dto entry: CheckpointDTO) throws -> CheckpointModel {
        
        return CheckpointModel(id: entry.id,
                               habitId: entry.habitId,
                               date: entry.dateString,
                               isDone: entry.isDone)
    }
    
}
