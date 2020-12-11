//
//  CheckpointModel.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 10/7/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation
import CoreStore

final class CheckpointDTO: CoreStoreObject {
    
    @Field.Stored("identifier", dynamicInitialValue: { UUID().uuidString })
    var id: String
    
    @Field.Stored("habitId")
    var habitId: String = ""
    
    @Field.Stored("dateString")
    // DD.MM.yyyy
    var date: Date = Date()
    
    @Field.Stored("isDone")
    var isDone: Bool = false
    
    func mutate(using checkpoint: CheckpointModel) {
        self.id = checkpoint.id
        self.habitId = checkpoint.habitId
        self.date = checkpoint.date
        self.isDone = checkpoint.isDone
    }
    
}


struct CheckpointWhereCause: AnyWhereClause {
    
    var predicate: NSPredicate
    
    init(_ predicate: NSPredicate) {
        self.predicate = predicate
    }
    
    init(value: Bool) {
        self.init(NSPredicate(value: value))
    }
    
    func applyToFetchRequest<T>(_ fetchRequest: NSFetchRequest<T>) where T : NSFetchRequestResult {
        fetchRequest.predicate = self.predicate
    }
    
}
