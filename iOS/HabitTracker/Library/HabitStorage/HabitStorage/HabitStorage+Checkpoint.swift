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
    static func set(checkpoints: [CheckpointModel], completion: BoolClosure?)
    static func setDone(checkpoint: CheckpointModel, completion: BoolClosure?)
    static func setDoneCheckpoint(with id: String, completion: BoolClosure?)
    static func setUndone(checkpoint: CheckpointModel, completion: BoolClosure?)
    static func setUndoneCheckpoint(with id: String, completion: BoolClosure?)
    static func getCheckpoints(for habitId: String, completion: Closure<RResult<[CheckpointModel]>>)
}

extension HabitStorage: CheckpointStorageAbstract {
    
    static func getCheckpointsForToday(completion: (RResult<[CheckpointModel]>) -> Void) {
        let _checkpoints = try? dataStack.fetchAll(From<CheckpointDTO>())
            // TODO: Optimize it!!!
            .compactMap { try? CheckpointModel.from(dto: $0) }
            .filter { $0.isToday }
        
        guard let checkpoints = _checkpoints else {
            completion(.failure(HTError.serialization))
            return
        }
        completion(.success(checkpoints))
    }
    
    static func setUndone(checkpoint: CheckpointModel, completion: BoolClosure?) {
        setUndoneCheckpoint(with: checkpoint.id, completion: completion)
    }
    
    static func setUndoneCheckpoint(with id: String, completion: BoolClosure?) {
        dataStack.perform { (transaction) in
            let model = try transaction.fetchOne(From<CheckpointDTO>().where(\.$id == id))
            model?.isDone = false
        } completion: { result in
            completion?(result.isSucceed)
        }
    }
    
    static func setDone(checkpoint: CheckpointModel, completion: BoolClosure?) {
        setDoneCheckpoint(with: checkpoint.id, completion: completion)
    }
    
    static func setDoneCheckpoint(with id: String, completion: BoolClosure?) {
        dataStack.perform { (transaction) in
            let model = try transaction.fetchOne(From<CheckpointDTO>().where(\.$id == id))
            model?.isDone = true
        } completion: { result in
            completion?(result.isSucceed)
        }
    }
    
    static func set(checkpoints: [CheckpointModel], completion: BoolClosure?) {
        dataStack.perform { transaction in
            checkpoints.forEach { checkpointModel in
                let model = transaction.create(Into<CheckpointDTO>())
                model.mutate(using: checkpointModel)
            }
        } completion: { (result) in
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
