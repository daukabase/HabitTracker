//
//  BackgroundTaskManager.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 12/16/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation
import BackgroundTasks

@available(iOS 13.0, *)
final class BackgroundTaskManager {
    
    private enum Constants {
        static let clearNotificationsTaskId = "com.challenge.me.kz.remove.extra.notifications"
    }
    
    private lazy var operationQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Notification remove"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    static let shared = BackgroundTaskManager()
    
    private init() {}
    
    func registerBackgroundTask() {
        BGTaskScheduler.shared.register(forTaskWithIdentifier: Constants.clearNotificationsTaskId, using: nil) { task in
            self.scheduleNotificationRemove()
            Notifications.shared.removeAllExtraNotifications()
        }
    }
    
    private func scheduleNotificationRemove() {
        let request = BGAppRefreshTaskRequest(identifier: Constants.clearNotificationsTaskId)
        request.earliestBeginDate = Date(timeIntervalSinceNow: 2 * 60 * 60)
                
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Could not schedule notification remove: \(error)")
        }
    }
    
    
    private func handleExtraNotificationsRemove(task: BGAppRefreshTask) {
        scheduleNotificationRemove()
        Notifications.shared.removeAllExtraNotifications()
        
        let operation = Operation()
        
        // Provide an expiration handler for the background task
        // that cancels the operation
        task.expirationHandler = {
            operation.cancel()
        }

        // Inform the system that the background task is complete
        // when the operation completes
        operation.completionBlock = {
            task.setTaskCompleted(success: !operation.isCancelled)
        }

        // Start the operation
        
        operationQueue.addOperation(operation)
    }
    
}
