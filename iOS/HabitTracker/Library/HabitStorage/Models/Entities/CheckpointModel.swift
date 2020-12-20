//
//  CheckpointModel.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 10/12/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation

final class CheckpointModel: Hashable {
    
    let id: String
    let habitId: String
    // DD.MM.yyyy
    let date: Date
    let isDone: Bool
    
    var notificationId: String {
        return id
    }
    
    var isToday: Bool {
        return date.isToday
    }
    
    var isMissed: Bool {
        let isPastCheckpoint = !isToday && date < Date()
        return isPastCheckpoint && !isDone
    }
    
    init(id: String, habitId: String, date: Date, isDone: Bool) {
        self.id = id
        self.habitId = habitId
        self.date = date
        self.isDone = isDone
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(date)
    }
    
    static func == (lhs: CheckpointModel, rhs: CheckpointModel) -> Bool {
        return lhs.id == rhs.id
    }
    
}

extension CheckpointModel: DTODecodable {
    
    typealias DTO = CheckpointDTO

    static func from(dto entry: CheckpointDTO) throws -> CheckpointModel {
        return CheckpointModel(id: entry.id,
                               habitId: entry.habitId,
                               date: entry.date,
                               isDone: entry.isDone)
    }
    
}
