//
//  HabitsInteractor.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 12/20/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation

final class HabitsInteractor {
    
    func getTotalHabits(completion: @escaping Closure<RResult<[Habit]>>) {
        Self._getTotalHabits { result in
            guard case let .success(habits) = result else {
                completion(result)
                return
            }
            
            self.additionalSetup(for: habits) { result in
                guard case let .success(habits) = result else {
                    completion(result)
                    return
                }
                completion(.success(habits.sortedByRemindTime()))
            }
        }
    }
    
    func getCheckpointsForToday(completion: @escaping Closure<RResult<[Habit]>>) {
        if Target.current == .fastlaneUiTest {
            completion(.success(FastlaneData.TestData.Habits.testData))
            return
        }

        HabitStorage.getCheckpointsForToday { result in
            switch result {
            case let .success(checkpoints):
                getHabits(for: checkpoints) { habits in
                    completion(.success(habits.sortedByRemindTime()))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Private Methods
    private static func _getTotalHabits(completion: @escaping Closure<RResult<[Habit]>>) {
        if Target.current == .fastlaneUiTest {
            completion(.success(FastlaneData.TestData.Habits.testData))
            return
        }
        
        HabitStorage.getTotalHabits { result in
            switch result {
            case let .success(models):
                HabitRepository.shared.getHabitViewModels(using: models) { habits in
                    completion(.success(habits))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    private func additionalSetup(for habits: [Habit], completion: @escaping Closure<RResult<[Habit]>>) {
        getCheckpointsForToday {  result in
            guard case let .success(todayHabits) = result else {
                completion(result)
                return
            }
            var uniqueHabits = Set(todayHabits)
            
            habits.forEach { uniqueHabits.insert($0) }
            
            completion(.success(Array(uniqueHabits)))
        }
    }
    
    private func getHabits(for checkpoints: [CheckpointModel], completion: @escaping Closure<[Habit]>) {
        let group = DispatchGroup()
        var habits = [Habit](repeating: .empty, count: checkpoints.count)
        
        checkpoints.enumerated().forEach { (index, checkpoint) in
            group.enter()
            HabitRepository.shared.getHabitViewModel(using: checkpoint) { result in
                defer {
                    group.leave()
                }
                guard let habit = result.value else {
                    return
                }
                habits[index] = habit
            }
        }
        
        group.notify(queue: .main) {
            completion(habits)
        }
    }
    
}
