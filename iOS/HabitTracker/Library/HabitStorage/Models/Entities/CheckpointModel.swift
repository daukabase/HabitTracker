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
