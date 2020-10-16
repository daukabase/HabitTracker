//
//  Notifications.swift
//  HabitTracker
//
//  Created by Daulet Dev on 7/12/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

final class Notifications: NSObject {
    
    private enum Constants {
        static let calendarComponents: Set<Calendar.Component> = Set([.year, .month, .day, .hour, .minute])
        static let checkpointNotificationActionPrefix = "checkpoint_of_habit_"
    }
    
    static let shared = Notifications()
    
    let notificationCenter = UNUserNotificationCenter.current()
    let options: UNAuthorizationOptions = [.alert, .sound, .badge]
    
    private override init() {
        super.init()
        notificationCenter.delegate = self
        
        print("[LET] check - \(UserDefaultsStorage.count)")
    }
    
    func notificationRequest() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        notificationCenter.requestAuthorization(options: options) {
            (didAllow, error) in
            if !didAllow {
                print("User has declined notifications")
            }
        }
    }
    
//    func scheduleNotification(notificationType: String) {
//        let userActions = "User Actions"
//
//        let content = UNMutableNotificationContent() // Содержимое уведомления
//
//        content.title = notificationType
//        content.body = "This is example how to create "
//        content.sound = UNNotificationSound.default
//        content.badge = 1
//        content.categoryIdentifier = userActions
//
//        let identifier = "Local Notification"
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//
//        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
//
//        notificationCenter.add(request) { (error) in
//            if let error = error {
//                print("Error \(error.localizedDescription)")
//            }
//        }
//
//        let doneAction = UNNotificationAction(identifier: .doneAction, title: "Mark As Done", options: [])
//
//        let category = UNNotificationCategory(identifier: userActions,
//                                              actions: [doneAction],
//                                              intentIdentifiers: [],
//                                              options: [])
//
//        notificationCenter.setNotificationCategories([category])
//    }
    
}

extension UserDefaultsStorage {
    @UserDefaultsBacked(key: "count", defaultValue: 0)
    static var count: Int
}

extension Notifications: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
        case UNNotificationDismissActionIdentifier:
            print("Dismiss Action")
        case UNNotificationDefaultActionIdentifier:
            print("Default")
        case .doneAction:
            UserDefaultsStorage.count = -4
            UIApplication.shared.applicationIconBadgeNumber = max(0, UIApplication.shared.applicationIconBadgeNumber - 1)
        default:
            print("Unknown action")
        }
        checkForCheckpointAction(for: response.actionIdentifier)
        
        completionHandler()
    }
    
}


extension Notifications {
    
    func setupNotification(for checkpoint: CheckpointModel, of habit: HabitModel) {
        let content = getNotificationContent(for: habit)
        let request = getRequest(for: checkpoint, content: content)
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
        
        let doneAction = UNNotificationAction(identifier: generateNotificationActionId(for: checkpoint),
                                              title: "Mark As Done", options: [])
        let category = UNNotificationCategory(identifier: .habitWithActionCategoryId,
                                              actions: [doneAction],
                                              intentIdentifiers: [],
                                              options: [])
        
        notificationCenter.setNotificationCategories([category])
    }
    
    private func generateNotificationActionId(for checkpoint: CheckpointModel) -> String {
        return Constants.checkpointNotificationActionPrefix + checkpoint.id
    }
    
    private func checkForCheckpointAction(for actionIdentifier: String) {
        guard actionIdentifier.hasPrefix(Constants.checkpointNotificationActionPrefix) else {
            return
        }
        var checkpointId = actionIdentifier
        checkpointId.removeFirst(Constants.checkpointNotificationActionPrefix.count)
        
        HabitStorage.setDoneCheckpoint(with: checkpointId, completion: { isSucceed in
            print("[DEBUG] \(isSucceed)")
        })
    }
    
    private func getNotificationContent(for habit: HabitModel) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent() // Содержимое уведомления
        
        content.title = habit.title
        content.body = habit.notes
        content.sound = UNNotificationSound.default
        // TODO: set badge number according to checkpoints count
        content.badge = 0
        content.categoryIdentifier = .habitWithActionCategoryId
        
        return content
    }
    
    private func getRequest(for checkpoint: CheckpointModel, content: UNMutableNotificationContent) -> UNNotificationRequest {
        var dateComponents = Calendar.current.dateComponents(Constants.calendarComponents,
                                                             from: checkpoint.date!)
        dateComponents.timeZone = .autoupdatingCurrent
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents,
                                                    repeats: false)
        
        
        let request = UNNotificationRequest(identifier: checkpoint.notificationId,
                                            content: content,
                                            trigger: trigger)
        return request
    }
 
    
    
}
