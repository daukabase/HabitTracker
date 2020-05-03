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
        
        FirebaseApp.configure()
        
        return true
    }
    
    private func setupRootView() {
        let home = UINavigationController(rootViewController: HomeViewController())
        let code = UIStoryboard.instantiate(ofType: NumberConfirmationViewController.self)!
        let onboarding = OnboardingPageViewController(with: [
            .init(type: .goal),
            .init(type: .track),
            .init(type: .challenge),
            .init(type: .auth),
        ])
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = home
        window?.makeKeyAndVisible()
        
        home.pushViewController(code, animated: true)
    }
    
}
