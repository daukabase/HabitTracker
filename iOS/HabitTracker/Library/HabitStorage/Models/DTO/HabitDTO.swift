//
//  HabitModel.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 10/7/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import CoreStore

final class HabitDTO: CoreStoreObject {
    
    @Field.Stored("identifier", dynamicInitialValue: { UUID().uuidString })
    var id: String
    
    @Field.Stored("title")
    var title: String = ""
    
    @Field.Stored("notes")
    var notes: String = ""
    
    @Field.Stored("colorHex")
    var colorHex: String = "#FFFFFF"
    
    @Field.Stored("icon")
    var icon: String = HabitIcon.meditation.rawValue
    
    @Field.Stored("startDate")
    var startDate: Date = Date()
    
    @Field.Stored("durationDays")
    var durationDays: Int = 0
    
    @Field.Stored("frequency")
    var frequency: String = ""
    
    func mutate(using habit: HabitModel) {
        self.id = habit.id
        self.colorHex = habit.colorHex
        self.durationDays = habit.durationDays
        self.frequency = try! habit.frequence.toDTO()
        self.icon = habit.icon.rawValue
        self.notes = habit.notes
        self.title = habit.title
        self.startDate = habit.startDate
    }
    
}
