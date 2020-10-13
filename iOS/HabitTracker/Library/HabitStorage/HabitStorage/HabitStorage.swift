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
    case storageOperation
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
                ],
                versionLock: [
                    "AchievementModel": [0xc39e90d0741c975, 0xe71a6381a09b7888, 0xa833541370ee4aa3, 0xda95a97fd3f1049],
                    "CheckpointModel": [0x35e2e5547be7c0e0, 0x75e38ad41603b4e3, 0x56729df7000d124f, 0xd4c7c4ecc80db42f],
                    "HabitModel": [0xf348782e6e2c97c7, 0x821b42d63c70f350, 0x57852979813635e1, 0x60263cc376af59ee]
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


