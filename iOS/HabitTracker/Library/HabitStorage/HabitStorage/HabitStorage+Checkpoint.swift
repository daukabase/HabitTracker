//
//  HabitStorage+Checkpoint.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 10/7/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation
import CoreStore

protocol CheckpointStorageAbstract {
    static func getCheckpointsForToday(completion: Closure<RResult<[CheckpointModel]>>)
    static func setCompleted(checkpoint: CheckpointModel, completion: BoolClosure?)
    static func getCheckpoints(for habitId: String, completion: Closure<RResult<[CheckpointModel]>>)
}

extension HabitStorage: CheckpointStorageAbstract {
    
    static func getCheckpointsForToday(completion: (RResult<[CheckpointModel]>) -> Void) {
        let _checkpoints = try? dataStack.fetchAll(
            From<CheckpointDTO>().where({ (checkpoint) -> CheckpointWhereCause in
                return CheckpointWhereCause(value: checkpoint.isToday)
            })
        ).compactMap { try? CheckpointModel.from(dto: $0) }
        
        guard let checkpoints = _checkpoints else {
            completion(.failure(HTError.serialization))
            return
        }
        completion(.success(checkpoints))
    }
    
    static func setCompleted(checkpoint: CheckpointModel, completion: BoolClosure?) {
        dataStack.perform { (transaction) in
            let model = try transaction.fetchOne(From<CheckpointDTO>().where(\.$id == checkpoint.id))
            model?.isDone = true
        } completion: { result in
            completion?(result.isSucceed)
        }
    }
    
    static func getCheckpoints(for habitId: String, completion: (RResult<[CheckpointModel]>) -> Void) {
        guard
            let dtos = try? dataStack.fetchAll(From<CheckpointDTO>().where(\.$habitId == habitId))
        else {
            completion(.failure(HTError.fetchError))
            return
        }
        let models = dtos.compactMap {
            try? CheckpointModel.from(dto: $0)
        }
        completion(.success(models))
    }
    
}
