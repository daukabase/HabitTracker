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
                    "CheckpointModel": [0xafc18d69dd6fb4ff, 0xcf5d48cec90bc1cb, 0xb5875d01333664dd, 0x18d8d31b4521a2c],
                    "HabitModel": [0xa582d0b06e7c90d9, 0xe42495295ae59c80, 0xba42a4525e376704, 0x6c99b54c7d8de6ff]
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


