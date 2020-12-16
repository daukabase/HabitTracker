//
//  HabitStorage+Checkpoint.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 10/7/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation
import CoreStore
import Promises

protocol CheckpointStorageAbstract {
    static func getCheckpointsForToday(completion: Closure<RResult<[CheckpointModel]>>)
    static func set(checkpoints: [CheckpointModel], completion: BoolClosure?)
    static func setDone(checkpoint: CheckpointModel, completion: BoolClosure?)
    static func setDoneCheckpoint(with id: String, completion: BoolClosure?)
    static func setUndone(checkpoint: CheckpointModel, completion: BoolClosure?)
    static func setUndoneCheckpoint(with id: String, completion: BoolClosure?)
    static func getCheckpoints(for habitId: String, completion:  @escaping Closure<RResult<[CheckpointModel]>>)
    static func removeCheckpoints(with ids: [String], completion: @escaping Closure<RResult<Void>>)
    static func getAllCheckpoints(completion: @escaping (RResult<Set<CheckpointModel>>) -> Void)
    static func getAllCheckpointsIds(completion: @escaping (RResult<Set<String>>) -> Void)
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
    
    static func getCheckpoints(for habitId: String, completion: @escaping (RResult<[CheckpointModel]>) -> Void) {
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
    
    static func getAllCheckpoints(completion: @escaping (RResult<Set<CheckpointModel>>) -> Void) {
        guard
            let dtos = try? dataStack.fetchAll(From<CheckpointDTO>())
        else {
            completion(.failure(HTError.fetchError))
            return
        }
        var checkpointsSet = Set<CheckpointModel>()
        
        dtos.forEach { dto in
            guard let checkpoint = try? CheckpointModel.from(dto: dto) else {
                return
            }
            checkpointsSet.insert(checkpoint)
        }
        
        completion(.success(checkpointsSet))
    }
    
    static func getAllCheckpointsIds(completion: @escaping (RResult<Set<String>>) -> Void) {
        guard
            let dtos = try? dataStack.fetchAll(From<CheckpointDTO>())
        else {
            completion(.failure(HTError.fetchError))
            return
        }
        var checkpointsIds = Set<String>()
        
        dtos.forEach { dto in
            checkpointsIds.insert(dto.id)
        }
        
        completion(.success(checkpointsIds))
    }
    
    static func removeCheckpoints(with ids: [String], completion: @escaping Closure<RResult<Void>>) {
        getCheckpoints(for: ids).then { checkpoints -> Promise<Void> in
            delete(checkpoints: checkpoints)
        }.then(on: .main) {
            completion(.success(Void()))
        }.catch(on: .main) { error in
            completion(.failure(error))
        }
    }
    
}

private extension HabitStorage {
    
    // MARK: - Promises
    private static func getCheckpoints(for ids: [String]) -> Promise<[CheckpointDTO]> {
        return Promise<[CheckpointDTO]>(on: .main) { fulfill, reject in
            Self.getCheckpoints(for: ids) { result in
                switch result {
                case let .success(models):
                    fulfill(models)
                case let .failure(error):
                    reject(error)
                }
            }
        }
    }
    
    private static func delete(checkpoints: [CheckpointDTO]) -> Promise<Void> {
        return Promise<Void>(on: .main) { fulfill, reject in
            dataStack.perform { transaction in
                transaction.delete(checkpoints)
            } completion: { result in
                switch result {
                case .success:
                    fulfill(Void())
                case let .failure(error):
                    reject(error)
                }
            }
        }
    }
    
    // MARK: - Checkpoints Getter Methods
    private static func getCheckpoints(for ids: [String], completion: @escaping Closure<RResult<[CheckpointDTO]>>) {
        let group = DispatchGroup()
        var checkpoints = [CheckpointDTO?](repeating: nil,
                                           count: ids.count)
        var hasError = false
        
        for (index, id) in ids.enumerated() {
            group.enter()
            
            getCheckpoint(for: id) { result in
                group.leave()
                
                guard let model = result.success else {
                    hasError = true
                    return
                }
                
                checkpoints[index] = model
            }
        }
        
        group.notify(queue: .main) {
            guard !hasError else {
                completion(.failure(HTError.fetchError))
                return
            }
            let checkpoints = checkpoints.compactMap { $0 }
            completion(.success(checkpoints))
        }
    }
    
    private static func getCheckpoint(for id: String, completion: @escaping Closure<RResult<CheckpointDTO>>) {
        guard
            let dtoModel = try? dataStack.fetchOne(From<CheckpointDTO>().where(\.$id == id))
        else {
            completion(.failure(HTError.fetchError))
            return
        }
        completion(.success(dtoModel))
    }
    
}
