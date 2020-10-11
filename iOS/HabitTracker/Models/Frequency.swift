//
//  Frequency.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 10/11/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation

enum Frequency {
    
    private enum Constants {
        static let daily = "daily"
        static let weekly = "weekly"
        static let divider = "#"
    }
    
    case daily(every: Int)
    case weekly([Day])
    
}

extension Frequency: DTOConvertible {
    
    func toDTO() throws -> String {
        switch self {
        case let .daily(every: day):
            return Constants.daily + Constants.divider + String(day)
        case let .weekly(days):
            let weekDaysString = days.map { String($0.rawValue) }.joined()
            
            return Constants.weekly + Constants.divider + weekDaysString
        }
    }
    
    static func from(dto: String) throws -> Frequency {
        let splitedDto = dto.components(separatedBy: Constants.divider)
        
        guard
            let type = splitedDto[safe: 0],
            let value = splitedDto[safe: 1],
            let frequency = Frequency.init(type: type, value: value)
        else {
            throw HTError.fetchError
        }
        
        return frequency
    }
    
    typealias DTO = String
    
    init?(type: String, value: String) {
        if type == Constants.daily, let dailyFreq = Int(value) {
            self = .daily(every: dailyFreq)
            debugPrint("INIT \(Constants.daily)")
            return
        }
        debugPrint("NOT \(Constants.daily)")
        guard type == Constants.weekly else {
            debugPrint("NOT \(Constants.weekly)")
            return nil
        }
        
        let days = value.compactMap { (char) -> Day? in
            guard let dayRaw = Int(String(char)) else {
                return nil
            }
            return Day(rawValue: dayRaw)
        }
        
        guard !days.isEmpty else {
            debugPrint("NOT enought days = \(days.count)")
            return nil
        }
        debugPrint("INIT \(Constants.weekly)")
        self = .weekly(days)
    }
    
}
