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
    
    func scheduleNotification(notificationType: String) {
        let userActions = "User Actions"
        
        let content = UNMutableNotificationContent() // Содержимое уведомления
        
        content.title = notificationType
        content.body = "This is example how to create "
        content.sound = UNNotificationSound.default
        content.badge = 1
        content.categoryIdentifier = userActions
        
        let identifier = "Local Notification"
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
        
        let doneAction = UNNotificationAction(identifier: .doneAction, title: "Mark As Done", options: [])
        
        let category = UNNotificationCategory(identifier: userActions,
                                              actions: [doneAction],
                                              intentIdentifiers: [],
                                              options: [])
        
        notificationCenter.setNotificationCategories([category])
    }
    
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
        completionHandler()
    }
    
}
