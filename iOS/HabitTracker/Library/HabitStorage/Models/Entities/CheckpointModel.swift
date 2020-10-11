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
    let date: String
    let isDone: Bool
    
    init(id: String, habitId: String, date: String, isDone: Bool) {
        self.id = id
        self.habitId = habitId
        self.date = date
        self.isDone = isDone
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
