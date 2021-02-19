//
//  HabitAbstractCellState.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 2/12/21.
//  Copyright © 2021 Daulet. All rights reserved.
//

import Foundation

class HabitAbstractCellState {
    
    let cell: HabitCell
    
    init(cell: HabitCell) {
        self.cell = cell
    }
    
    func setDone(viewModel: HabitCellViewModel?) {
        assertionFailure()
    }
    
    func setUndone(viewModel: HabitCellViewModel?) {
        assertionFailure()
    }
    
}
