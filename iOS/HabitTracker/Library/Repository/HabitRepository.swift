//
//  HabitRepository.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 10/7/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation
import Promises

final class HabitRepository {
    
    // MARK: - Constants
    enum Constants {
        static let queue = DispatchQueue.global(qos: .userInteractive)
    }
    
    // MARK: - Properties
    static let shared = HabitRepository()
    
    // MARK: - Methods
    func create(habit: HabitModel, completion: EmptyClosure?) {
        createHabitPromise(habit: habit).then {
            return self.generateHabitBehaviorPromise(habit: habit)
        }.catch { error in
            print(error.localizedDescription)
        }.always {
            completion?()
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
    
    private func generateHabitBehaviorPromise(habit: HabitModel) -> Promise<Void> {
        return Promise<Void>(on: Constants.queue) { fulfill, reject in
            CheckpointsRepository.shared.setupCheckpoints(for: habit) { isSucceed in
                guard isSucceed else {
                    reject(HTError.storageOperation)
                    return
                }
                fulfill(Void())
            }
        }
    }
    
}
