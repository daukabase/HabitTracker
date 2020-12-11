//
//  HabitDetailsInteractor.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 10/14/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation
import Promises

protocol HabitDetailsInteractorInput {
    func create(habit: HabitModel, remindTime: Date?, completion: Closure<RResult<Void>>?)
    func edit(habit: HabitModel, remindTime: Date?, completion: Closure<RResult<Void>>?)
    func loadRemindTime(for habit: Habit, completion: Closure<RResult<Date>>?)
}

final class HabitDetailsInteractor: HabitDetailsInteractorInput {
    
    // MARK: - HabitDetailsInteractorInput
    func create(habit: HabitModel, remindTime: Date?, completion: Closure<RResult<Void>>?) {
        HabitRepository.shared.create(habit: habit, remindTime: remindTime, completion: completion)
    }
    
    func edit(habit: HabitModel, remindTime: Date?, completion: Closure<RResult<Void>>?) {
        HabitRepository.shared.edit(habit: habit, remindTime: remindTime, completion: completion)
    }
    
    func loadRemindTime(for habit: Habit, completion: Closure<RResult<Date>>?) {
        HabitStorage.getCheckpoints(for: habit.id) { result in
            switch result {
            case let .success(checkpoints):
                let maxCheckpoint = checkpoints.max { (ch1, ch2) -> Bool in
                    return ch1.date > ch2.date
                }
                guard let date = maxCheckpoint?.date else {
                    completion?(.failure(HTError.fetchError))
                    return
                }
                completion?(.success(date))
            case .failure:
                completion?(.failure(HTError.fetchError))
            }
        }
    }
    
}
