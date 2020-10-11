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
    
    @Field.Stored("date")
    // DD.MM.yyyy
    var date: String = "16.12.1991"
    
    @Field.Stored("isDone")
    var isDone: Bool = false
    
}

