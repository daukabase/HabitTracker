//
//  HabitRepository.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 10/7/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation
import Promises

protocol HabitRepositoryAbstract {
    func create(habit: HabitModel, remindTime: Date?, completion: Closure<RResult<Void>>?)
    func edit(habit: HabitModel, remindTime: Date?, completion: Closure<RResult<Void>>?)
    func getHabitViewModel(using checkpoint: CheckpointModel, completion: Closure<RResult<Habit>>?)
}

final class HabitRepository: HabitRepositoryAbstract {
    
    // MARK: - Constants
    enum Constants {
        static let queue = DispatchQueue.global(qos: .userInteractive)
    }
    
    // MARK: - Properties
    static let shared: HabitRepositoryAbstract = HabitRepository()
    
    // MARK: - HabitRepositoryAbstract
    func create(habit: HabitModel, remindTime: Date?, completion: Closure<RResult<Void>>?) {
        createHabitPromise(habit: habit).then {
            return self.generateHabitBehaviorPromise(habit: habit, remindTime: remindTime)
        }.then {
            completion?(.success($0))
        }.catch { error in
            completion?(.failure(error))
        }
    }
    
    func edit(habit: HabitModel, remindTime: Date?, completion: Closure<RResult<Void>>?) {
        habit
    }
    
    func getHabitViewModel(using checkpoint: CheckpointModel, completion: Closure<RResult<Habit>>?) {
        HabitStorage.getHabit(for: checkpoint.habitId) { result in
            guard
                let _habit = result.value,
                let habit = Habit(habit: _habit, checkpoint: checkpoint)
            else {
                completion?(.failure(HTError.serialization))
                return
            }
            
            habit.checkpoint = checkpoint
            habit.updateGoal {
                completion?(.success(habit))
            }
        }
    }
        
    // MARK: - Promises
    private func createHabitPromise(habit: HabitModel) -> Promise<Void> {
        return Promise<Void>(on: Constants.queue) { fulfill, reject in
            HabitStorage.create(habit: habit) { isSucceed in
                guard isSucceed else {
                    reject(HTError.storageOperation)
                    return
                }
                fulfill(Void())
            }
        }
    }
    
    private func generateHabitBehaviorPromise(habit: HabitModel, remindTime: Date?) -> Promise<Void> {
        return Promise<Void>(on: Constants.queue) { fulfill, reject in
            CheckpointsRepository.shared.setupCheckpoints(for: habit, with: remindTime) { isSucceed in
                guard isSucceed else {
                    reject(HTError.storageOperation)
                    return
                }
                fulfill(Void())
            }
        }
    }
    
}
