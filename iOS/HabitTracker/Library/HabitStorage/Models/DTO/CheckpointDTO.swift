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
    var dateString: String = "16.12.1991"
    
    @Field.Stored("isDone")
    var isDone: Bool = false
    
    @Field.Virtual(
        "isToday",
        customGetter: { object, field in
            let date = object.$dateString.value.date(with: .storingFormat)
            
            return date?.isToday ?? false
        }
    )
    var isToday: Bool
    
    func mutate(using checkpoint: CheckpointModel) {
        self.id = checkpoint.id
        self.habitId = checkpoint.habitId
        self.dateString = checkpoint.dateString
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
