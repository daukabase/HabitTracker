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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupRootView()
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysShow
        
        FirebaseApp.configure()
        
        return true
    }
    
    private func setupRootView() {
        let home = HomeViewController()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: home)
        window?.makeKeyAndVisible()
    }
    
}
