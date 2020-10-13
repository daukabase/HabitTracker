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
    func create(habit: HabitModel, completion: EmptyClosure?)
}

final class HabitDetailsInteractor: HabitDetailsInteractorInput {
    
    
    // MARK: - HabitDetailsInteractorInput
    func create(habit: HabitModel, completion: EmptyClosure?) {
        HabitRepository.shared.create(habit: habit, completion: completion)
    }
    
}
