//
//  HabitModel.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 10/11/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation

final class HabitModel {
    
    let id: String
    let title: String
    let notes: String
    let frequence: Frequency
    let colorHex: String
    let icon: HabitIcon
    // DD.MM.yyyy
    let startDate: String
    let durationDays: Int
    
    init(id: String, title: String, notes: String, frequence: Frequency, colorHex: String, icon: String, startDate: String, durationDays: Int) {
        self.id = id
        self.title = title
        self.notes = notes
        self.colorHex = colorHex
        self.frequence = frequence
        self.icon = HabitIcon(rawValue: icon)
        self.startDate = startDate
        self.durationDays = durationDays
    }
    
}

extension HabitModel: DTODecodable {
    
    typealias DTO = HabitDTO

    static func from(dto entry: HabitDTO) throws -> HabitModel {
        guard let frequency = try? Frequency.from(dto: entry.frequency) else {
            throw HTError.serialization
        }
        
        return HabitModel(id: entry.id,
                          title: entry.title,
                          notes: entry.notes,
                          frequence: frequency,
                          colorHex: entry.colorHex,
                          icon: entry.icon,
                          startDate: entry.startDate,
                          durationDays: entry.durationDays)
    }
    
}
