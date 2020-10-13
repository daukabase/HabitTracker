//
//  CheckpointsRepository.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 10/7/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation

final class CheckpointsRepository {
    
    // MARK: - Properties
    static let shared = CheckpointsRepository()
    
    // MARK: - Init
    private init() {
        
    }
    
    // MARK: - Methods
    func setupCheckpoints(for habit: HabitModel, completion: BoolClosure?) {
        let checkpoints = generateCheckpoints(for: habit)
        HabitStorage.set(checkpoints: checkpoints) { isSucceed in
            defer {
                completion?(isSucceed)
            }
            guard isSucceed else { return }
            
            checkpoints.forEach { checkpointModel in
                Notifications.shared.setupNotification(for: checkpointModel, of: habit)
            }
        }
    }
    
    // MARK: - Private Methods
    private func generateCheckpoints(for habit: HabitModel) -> [CheckpointModel] {
        guard let startDate = habit.startDate.date(with: .storingFormat) else {
            assertionFailure("Something wrong")
            return []
        }
        let dates = generateDates(for: habit.frequence,
                                  startDate: startDate,
                                  durationDays: habit.durationDays)
        
        let checkpoints = dates.map { date -> CheckpointModel in
            return CheckpointModel(id: UUID().uuidString,
                                   habitId: habit.id,
                                   date: date.string(with: .storingFormat),
                                   isDone: false)
        }
        
        return checkpoints
    }
    
    private func generateDates(for frequency: Frequency, startDate: Date, durationDays: Int) -> [Date] {
        var dates = [Date]()
        switch frequency {
        case let .weekly(days):
            let days = Set(days)
            
            for dayCount in 0..<durationDays {
                guard let date = Calendar.current.date(byAdding: .day, value: dayCount, to: startDate) else {
                    assertionFailure("Something wrong")
                    continue
                }
                
                guard days.contains(date.day) else {
                    continue
                }
                
                dates.append(date)
            }
        case .daily:
            fatalError("Not available")
        }
        
        return dates
    }
}
