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

struct PersonDTO: Codable {
    
    struct Name {
        let first: String
        let last: String
    }
    
    
}

struct DoneHabit {
 
    static let mock = DoneHabit(id: "someId", title: "Running", notes: "run vasya run", icon: Asset.dance.image, date: .distantPast)
    
    let id: String
    let title: String
    let notes: String
    let icon: UIImage
    // TODO: update date
    let date: Date
    
    init(id: String, title: String, notes: String, icon: UIImage, date: Date) {
        self.id = id
        self.title = title
        self.notes = notes
        self.date = date
        self.icon = icon
    }
    
}

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
    
    func scheduleNotification(doneHabit: DoneHabit) {
        let userActions = "User Actions"
        
        let content = UNMutableNotificationContent() // Содержимое уведомления
        content.attachments = []
        content.title = doneHabit.title
        content.body = doneHabit.notes
        content.sound = UNNotificationSound.default
        content.badge = 1
        content.categoryIdentifier = userActions
//        content.userInfo = doneHabit.toJson()
        
        if let attachment = UNNotificationAttachment.create(identifier: "identifier", image: doneHabit.icon, options: nil) {
            // where myImage is any UIImage
            content.attachments = [attachment]
        }
        
        let identifier = getNotificationId(for: doneHabit)
        
        let date = Date.distantFuture // Here is date
        let triggerDaily = Calendar.current.dateComponents([.hour,.minute,.second,], from: date)
        
        #if DEBUG
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        #else
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
        #endif
        
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
    
    private func getNotificationId(for habit: DoneHabit) -> String {
        return habit.id
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

fileprivate extension UNNotificationAttachment {

    static func create(identifier: String, image: UIImage, options: [NSObject : AnyObject]?) -> UNNotificationAttachment? {
        let fileManager = FileManager.default
        let tmpSubFolderName = ProcessInfo.processInfo.globallyUniqueString
        let tmpSubFolderURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(tmpSubFolderName, isDirectory: true)
        do {
            try fileManager.createDirectory(at: tmpSubFolderURL, withIntermediateDirectories: true, attributes: nil)
            let imageFileIdentifier = identifier + ".png"
            let fileURL = tmpSubFolderURL.appendingPathComponent(imageFileIdentifier)
            let imageData = UIImage.pngData(image)
            
            try imageData()?.write(to: fileURL)
            let imageAttachment = try UNNotificationAttachment.init(identifier: imageFileIdentifier, url: fileURL, options: options)
            return imageAttachment
        } catch {
            print("error " + error.localizedDescription)
        }
        return nil
    }
    
}
