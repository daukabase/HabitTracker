//
//  HabitStorage+HabitStorageAbstract.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 10/7/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation

protocol HabitStorageAbstract {
    static func getHabit(for id: String, completion: Closure<RResult<HabitModel>>)
    static func create(habit: HabitModel, completion: BoolClosure?)
    static func edit(habit: HabitModel, completion: BoolClosure?)
    static func delete(habit: HabitModel, completion: BoolClosure?)
}

extension HabitStorage: HabitStorageAbstract {
    
    static func getHabit(for id: String, completion: (RResult<HabitModel>) -> Void) {
        fatalError("not implemented")
    }
    
    static func create(habit: HabitModel, completion: BoolClosure?) {
        fatalError("not implemented")
    }
    
    static func edit(habit: HabitModel, completion: BoolClosure?) {
        fatalError("not implemented")
    }
    
    static func delete(habit: HabitModel, completion: BoolClosure?) {
        fatalError("not implemented")
    }
    
}
