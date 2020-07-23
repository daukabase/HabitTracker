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
    let layer = TestNetworkLayer()
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupRootView()
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        
        FirebaseApp.configure()
        setupAppearence()
        setupNotifications()
        
        
        
        layer.request()
        
        return true
    }
    
    private func setupNotifications() {
        
        Notifications.shared.notificationRequest()
    }
    
    private func setupRootView() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        #if DEBUG
            UserDefaultsStorage.isOnboardingCompleted = false
        #endif
        
        UserDefaultsStorage.isOnboardingCompleted ? routeToHome() : routeToOnboarding()
    }
    
    private func routeToOnboarding() {
        let controller = OnboardingPageViewController(with: [
            .init(type: .goal),
            .init(type: .track),
            .init(type: .challenge),
            .init(type: .auth),
        ])
        window?.rootViewController = UINavigationController(rootViewController: controller)
    }
    
    private func routeToHome() {
        let controller = HomeViewController()
        
        window?.rootViewController = UINavigationController(rootViewController: controller)
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

struct UserDefaultsStorage {
    @UserDefaultsBacked(key: "isOnboardingCompleted", defaultValue: false)
    static var isOnboardingCompleted: Bool
}
