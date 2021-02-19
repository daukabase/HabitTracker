//
//  AppDelegate.swift
//  HabitTracker
//
//  Created by Daulet on 3/6/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications
import Fabric
import IQKeyboardManagerSwift
import BackgroundTasks

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AppInterfaceConfigurator.shared.configure()
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        
        FirebaseApp.configure()
        setupAppearence()
        setupNotifications()
        
        return true
    }
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        if #available(iOS 13.0, *) {
            BackgroundTaskManager.shared.registerBackgroundTask()
        }
        
        return true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        NotificationCenter.default.post(name: .updateHabits, object: nil)
    }
    
    private func setupNotifications() {
        Notifications.shared.notificationRequest()
    }
    
    private func setupAppearence() {
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().isTranslucent = false
    }
    
}

extension String {
    static let doneAction = "habit_done_action"
}
