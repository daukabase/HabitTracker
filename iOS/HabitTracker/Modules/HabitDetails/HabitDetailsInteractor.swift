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
}

final class HabitDetailsInteractor: HabitDetailsInteractorInput {
    
    // MARK: - HabitDetailsInteractorInput
    func create(habit: HabitModel, remindTime: Date?, completion: Closure<RResult<Void>>?) {
        HabitRepository.shared.create(habit: habit, remindTime: remindTime, completion: completion)
    }
    
    func edit(habit: HabitModel, remindTime: Date?, completion: Closure<RResult<Void>>?) {
        HabitRepository.shared.edit(habit: habit, remindTime: remindTime, completion: completion)
    }
    
}
