//
//  HabitStorage.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 10/7/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation
import CoreStore

enum HTError: LocalizedError {
    
    case networkError
    case fetchError
    case serialization
    
    var errorDescription: String? {
        return "Something wrong"
    }
}


public final class HabitStorage {
    
    private init() {
        
    }
    
    static let dataStack: DataStack = {
        let dataStack = DataStack(
            CoreStoreSchema(
                modelVersion: "V1",
                entities: [
                    Entity<HabitDTO>("HabitModel"),
                    Entity<CheckpointDTO>("CheckpointModel"),
                    Entity<AchievementDTO>("AchievementModel")
                ]
            )
        )
        
        try! dataStack.addStorageAndWait(
            SQLiteStore(
                fileName: "HabitStorage.sqlite",
                localStorageOptions: .recreateStoreOnModelMismatch
            )
        )
        
        return dataStack
    }()
    
}


