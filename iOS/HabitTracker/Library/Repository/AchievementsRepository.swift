//
//  AchievementsRepository.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 10/7/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation
import Promises

final class AchievementsRepository {
    
    // MARK: - Properties
    static let shared = AchievementsRepository()
    
    // MARK: - Internal Methods
    func getAchievements(for habitId: String, completion: @escaping Closure<RResult<[AbstractAchievement]>>) {
        getCheckpointsPromise(for: habitId).then { checkpoints in
            let achievements = self.getAchievements(from: checkpoints)
            completion(.success(achievements))
        }.catch { error in
            completion(.failure(error))
        }
    }
    
    // MARK: - Promises
    private func getCheckpointsPromise(for habitId: String) -> Promise<[CheckpointModel]> {
        Promise<[CheckpointModel]>(on: .main) { (fulfill, reject) in
            HabitStorage.getCheckpoints(for: habitId) { result in
                switch result {
                case let .success(checkpoints):
                    fulfill(checkpoints)
                case let .failure(error):
                    reject(error)
                }
            }
        }
    }
    
    // MARK: - Private Logic
    private func getAchievements(from checkpoints: [CheckpointModel]) -> [AbstractAchievement] {
        let (currentStreak, longestStreak) = getStreaks(for: checkpoints)
        let (totalDone, goal) = getGoal(for: checkpoints)
        
        return [
            CommonAchievement.getCurrentStreak(for: currentStreak),
            CommonAchievement.getLongestStreak(for: longestStreak),
            CommonAchievement.getTotalDone(for: totalDone),
            GoalAchievement(completedDays: totalDone, totalDays: goal)
        ]
    }
    
    // MARK: - Achevements Computing logic
    private func getStreaks(for checkpoints: [CheckpointModel]) -> (currentStreak: Int, longestStreak: Int) {
        let now = Date()
        var (currentSkreak, maxStreak) = (0, 0)
        
        for model in checkpoints {
            if model.isDone {
                currentSkreak += 1
                maxStreak = max(currentSkreak, maxStreak)
            } else if model.isToday {
                break
            } else if let date = model.date, date <= now {
                break
            } else {
                currentSkreak = 0
            }
        }
        
        return (currentSkreak, maxStreak)
    }
    
    private func getGoal(for checkpoints: [CheckpointModel]) -> (done: Int, goal: Int) {
        let totalDone = getTotalDone(for: checkpoints)
        return (totalDone, checkpoints.count)
    }
    
    private func getTotalDone(for checkpoints: [CheckpointModel]) -> Int {
        let totalDone = checkpoints.reduce(0) { (result, model) -> Int in
            return result + (model.isDone ? 1 : 0)
        }
        return totalDone
    }
    
}
