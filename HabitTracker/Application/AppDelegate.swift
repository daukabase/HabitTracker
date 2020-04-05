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


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupRootView()
        configureAppearence()
        
        FirebaseApp.configure()
        
        return true
    }
    
    private func setupRootView() {
        let home = HomeViewController()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: home)
        window?.makeKeyAndVisible()
    }
    
    private func configureAppearence() {
//        let titleAttributes: [StringAttribute] = [
//            .aligment(.center),
//            .lineHeight(19, font: R.font.montserratBold(size: 15)!),
//        ]
//        UINavigationBar.appearance().titleTextAttributes = titleAttributes.toDictionary()
        UIBarButtonItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.clear], for: .normal)
    }
    
}
