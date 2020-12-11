//
//  CheckpointsRepository.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 10/7/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation

protocol CheckpointsRepositoryAbstract {
    func setupCheckpoints(for habit: HabitModel, with remindTime: Date?, completion: BoolClosure?)
    func removeFutureCheckpoints(for habitId: String, completion: @escaping Closure<RResult<Void>>)
}

final class CheckpointsRepository: CheckpointsRepositoryAbstract {
    
    // MARK: - Properties
    static let shared = CheckpointsRepository()
    
    // MARK: - Init
    private init() {
        
    }
    
    // MARK: - CheckpointsRepositoryAbstract
    func setupCheckpoints(for habit: HabitModel,
                          with remindTime: Date?,
                          completion: BoolClosure?) {
        let checkpoints = generateCheckpoints(for: habit, remindTime: remindTime)
        
        HabitStorage.set(checkpoints: checkpoints) { isSucceed in
            defer {
                completion?(isSucceed)
            }
            guard isSucceed, remindTime != nil else { return }
            
            checkpoints.forEach { checkpointModel in
                Notifications.shared.setupNotification(for: checkpointModel, of: habit)
            }
        }
    }
    
    func removeFutureCheckpoints(for habitId: String, completion: @escaping Closure<RResult<Void>>) {
        HabitStorage.getCheckpoints(for: habitId) { result in
            switch result {
            case let .success(checkpoints):
                let futureCheckpointsIds = self.getFuture(checkpoints: checkpoints).map { $0.id }
                HabitStorage.removeCheckpoints(with: futureCheckpointsIds) { result in
                    completion(result)
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Private Methods
    private func generateCheckpoints(for habit: HabitModel, remindTime: Date?) -> [CheckpointModel] {
        guard let startDate = habit.startDate.date(with: .storingFormat) else {
            assertionFailure("Something wrong")
            return []
        }
        let dates = generateDates(for: habit.frequence,
                                  startDate: startDate,
                                  durationDays: habit.durationDays,
                                  checkpointAppearTime: remindTime)
        
        let checkpoints = dates.map { date -> CheckpointModel in
            return CheckpointModel(id: UUID().uuidString,
                                   habitId: habit.id,
                                   date: date.string(with: .storingFormat),
                                   isDone: false)
        }
        
        return checkpoints
    }
    
    private func generateDates(for frequency: Frequency,
                               startDate: Date,
                               durationDays: Int,
                               checkpointAppearTime: Date?) -> [Date] {
        let defaultAppearTime = (hour: 0, minute: 0)
        var dates = [Date]()
        
        let (hour, minute): (Int, Int) = {
            guard let checkpointAppearTime = checkpointAppearTime else {
                return defaultAppearTime
            }
            return (checkpointAppearTime.hour, checkpointAppearTime.minute)
        }()
        
        switch frequency {
        case let .weekly(days):
            let days = Set(days)
            
            print("\n\n\nAllowed days: ", Array(days).reduce(" ", { $0 + " " + String(describing: $1) }))
            for dayCount in 0..<durationDays {
                print("____________________________________________________________")
                guard var date = Calendar.current.date(byAdding: .day, value: dayCount, to: startDate) else {
                    assertionFailure("Something wrong")
                    continue
                }
                let dateString = date.string(with: .storingFormat)
                print("Date to process: ", dateString)
                print("Date day: ", date.day)
                guard days.contains(date.day) else {
                    continue
                }
                // shouldn't generate fututre dates
                guard date.isToday || date > Date() else {
                    continue
                }
                
                if let dateWithUpdatedTime = Calendar.current.date(bySettingHour: hour,
                                                     minute: minute,
                                                     second: .zero,
                                                     of: date) {
                    print("Date with updated time: ", dateWithUpdatedTime.string(with: .storingFormat))
                    date = dateWithUpdatedTime
                }
                
                dates.append(date)
                print("Date added: ", date.string(with: .storingFormat))
            }
        case .daily:
            fatalError("Not available")
        }
        
        return dates
    }
    
    private func getFuture(checkpoints: [CheckpointModel]) -> [CheckpointModel] {
        return checkpoints.filter { checkpoint in
            guard let date = checkpoint.date, !checkpoint.isDone else {
                return false
            }
            return date > Date()
        }
    }
    
}
