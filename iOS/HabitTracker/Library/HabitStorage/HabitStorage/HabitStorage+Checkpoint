//
//  HabitStorage+CheckpointStorageAbstract.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 10/7/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation

protocol CheckpointStorageAbstract {
    static func getCheckpointsForToday(completion: Closure<RResult<Checkpoint>>)
    static func setCompleted(checkpoint: Checkpoint)
    static func getCheckpoints(for habitId: String, completion: Closure<RResult<[Checkpoint]>>)
}

extension HabitStorage: CheckpointStorageAbstract {
    
    static func getCheckpointsForToday(completion: (RResult<Checkpoint>) -> Void) {
        fatalError("not implemented")
    }
    
    static func setCompleted(checkpoint: Checkpoint) {
        fatalError("not implemented")
    }
    
    static func getCheckpoints(for habitId: String, completion: (RResult<[Checkpoint]>) -> Void) {
        fatalError("not implemented")
    }
    
}
