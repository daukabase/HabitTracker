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
        HabitStorage.getTotalHabits { result in
            switch result {
            case let .success(models):
                let habits = models.compactMap { Habit(habit: $0, checkpoint: nil) }
                
                completion(.success(habits))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func getCheckpointsForToday(completion: @escaping Closure<RResult<[Habit]>>) {
        HabitStorage.getCheckpointsForToday { result in
            switch result {
            case let .success(checkpoints):
                getHabits(for: checkpoints) { habits in
                    completion(.success(habits))
                }
            case let .failure(error):
                completion(.failure(error))
            }
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
            let habits = habits.sorted { (h1, h2) -> Bool in
                guard let date1 = h1.checkpoint?.date, let date2 = h2.checkpoint?.date else {
                    return false
                }
                return date1 < date2
            }
            completion(habits)
        }
    }
    
}
