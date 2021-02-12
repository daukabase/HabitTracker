//
//  HabitCellViewModel.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 12/20/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit
import Haptica

final class HabitCellViewModel: HabitDisplayCellViewModel {
    
    // MARK: - Computed Properties
    var isCheckpointForTodayCompleted: Bool {
        return habit.isCurrentCompleted
    }
    
    // MARK: Init
    override init(habit: Habit) {
        super.init(habit: habit)
        
        self.cellType = .habitActionable
    }
    
    // MARK: - Methods
    func set(isSelected: Bool, completion: EmptyClosure?) {
        guard let checkpoint = habit.checkpoint else {
            return
        }
        
        let toogleCheckpointCompletion: BoolClosure = { [weak self] isSucceed in
            guard isSucceed else { return }
            self?.habit.updateGoal {
                completion?()
            }
        }
        
        if isSelected {
            HabitStorage.setDone(checkpoint: checkpoint, completion: toogleCheckpointCompletion)
        } else {
            HabitStorage.setUndone(checkpoint: checkpoint, completion: toogleCheckpointCompletion)
        }
    }
    
}