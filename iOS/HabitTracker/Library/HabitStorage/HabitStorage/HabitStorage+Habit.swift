//
//  HabitStorage+Habit.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 10/7/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation
import CoreStore

protocol HabitStorageAbstract {
    static func getHabit(for id: String, completion: Closure<RResult<HabitModel>>)
    static func create(habit: HabitModel, completion: BoolClosure?)
    static func edit(habit: HabitModel, completion: BoolClosure?)
    static func delete(habit: HabitModel, completion: BoolClosure?)
}


extension HabitStorage: HabitStorageAbstract {
    
    static func getHabit(for id: String, completion: (RResult<HabitModel>) -> Void) {
        guard
            let dto = try? dataStack.fetchOne(
                From<HabitDTO>().where(\.$id == id)
            ),
            let model = try? HabitModel.from(dto: dto)
        else {
            completion(.failure(HTError.fetchError))
            return
        }
        
        completion(.success(model))
    }
    
    static func create(habit: HabitModel, completion: BoolClosure?) {
        dataStack.perform { transaction in
            let model = transaction.create(Into<HabitDTO>())
            
            model.mutate(using: habit)
        } completion: { (result) in
            completion?(result.isSucceed)
        }
    }
    
    static func edit(habit: HabitModel, completion: BoolClosure?) {
        dataStack.perform { (transaction) in
            let model = try transaction.fetchOne(From<HabitDTO>().where(\.$id == habit.id))
            
            model?.mutate(using: habit)
        } completion: { (result) in
            completion?(result.isSucceed)
        }

    }
    
    static func delete(habit: HabitModel, completion: BoolClosure?) {
        dataStack.perform { (transaction) in
            try transaction.deleteAll(From<HabitDTO>().where(\.$id == habit.id))
        } completion: { (result) in
            completion?(result.isSucceed)
        }

    }
    
}
