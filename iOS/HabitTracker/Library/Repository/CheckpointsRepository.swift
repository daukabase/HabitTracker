//
//  CheckpointsRepository.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 10/7/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation

protocol CheckpointsRepositoryAbstract {
    func setupCheckpoints(for habit: HabitModel, with remindTime: Date?, completion: BoolClosure?)
    func removeFutureCheckpoints(for habitId: String, completion: @escaping Closure<RResult<[CheckpointModel]>>)
}

final class CheckpointsRepository: CheckpointsRepositoryAbstract {
    
    // MARK: - Properties
    static let shared = CheckpointsRepository()
    
    // MARK: - Init
    private init() {
        
    }
    
    // MARK: - CheckpointsRepositoryAbstract
    func setupCheckpoints(for habit: HabitModel,
                          with remindTime: Date?,
                          completion: BoolClosure?) {
        let checkpoints = generateCheckpoints(for: habit, remindTime: remindTime)
        
        HabitStorage.set(checkpoints: checkpoints) { isSucceed in
            defer {
                completion?(isSucceed)
            }
            guard isSucceed, remindTime != nil else { return }
            
            checkpoints.forEach { checkpointModel in
                Notifications.shared.setupNotification(for: checkpointModel, of: habit)
            }
        }
    }
    
    func removeFutureCheckpoints(for habitId: String, completion: @escaping Closure<RResult<[CheckpointModel]>>) {
        HabitStorage.getCheckpoints(for: habitId) { result in
            switch result {
            case let .success(checkpoints):
                let futureCheckpoints = self.getFuture(checkpoints: checkpoints)
                let futureCheckpointsIds = futureCheckpoints.map { $0.id }
                
                HabitStorage.removeCheckpoints(with: futureCheckpointsIds) { result in
                    switch result {
                    case .success:
                        completion(.success(futureCheckpoints))
                    case let .failure(error):
                        completion(.failure(error))
                    }
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Private Methods
    private func generateCheckpoints(for habit: HabitModel, remindTime: Date?) -> [CheckpointModel] {
        let dates = generateDates(for: habit, remindTime: remindTime)
        
        let checkpoints = dates.map { date -> CheckpointModel in
            return CheckpointModel(id: UUID().uuidString,
                                   habitId: habit.id,
                                   date: date,
                                   isDone: false)
        }
        
        return checkpoints
    }
    
    private func generateDates(for habit: HabitModel, remindTime: Date?) -> [Date] {
        let generator = CheckpointDateGenerator(for: habit.frequence,
                                                startDate: habit.startDate,
                                                durationDays: habit.durationDays,
                                                checkpointAppearTime: remindTime)
        return generator.generateDatesForCheckpoints()
    }
    
    private func getFuture(checkpoints: [CheckpointModel]) -> [CheckpointModel] {
        return checkpoints.filter { checkpoint in
            guard !checkpoint.isDone else {
                return false
            }
            return checkpoint.date > Date() || checkpoint.isToday
        }
    }
    
}
