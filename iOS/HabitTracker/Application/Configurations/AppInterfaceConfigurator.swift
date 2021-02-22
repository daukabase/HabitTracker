//
//  AppInterfaceConfigurator.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 2/19/21.
//  Copyright © 2021 Daulet. All rights reserved.
//

import UIKit

final class AppInterfaceConfigurator {
    
    // MARK: - Properties
    static let shared = AppInterfaceConfigurator()
    
    private lazy var window: UIWindow = {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        return window
    }()
    
    // MARK: - Init
    private init() {}
    
    // MARK: - Internal Methods
    func configure() {
        setupRootView()
    }
    
    func routeToHome() {
        _routeToHome(animated: true)
    }
    
    // MARK: - Private Methods
    private func routeToOnboarding() {
        let controller = OnboardingPageViewController(with: [
            .init(type: .goal),
            .init(type: .track),
            .init(type: .getStarted),
        ])
        
        setupRoot(viewController: controller, animated: false)
    }
    
    private func _routeToHome(animated: Bool) {
        let controller = HomeViewController()
        setupRoot(viewController: controller, animated: animated)
    }
    
    private func setupRoot(viewController: UIViewController, animated: Bool) {
        window.rootViewController = PreferredNavigationController(rootViewController: viewController)
        
        guard animated else {
            return
        }
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: {},
                          completion: nil)
    }
    
    private func setupRootView() {
        #if DEBUG
            UserDefaultsStorage.isOnboardingCompleted = true
        #endif
        
        UserDefaultsStorage.isOnboardingCompleted ? _routeToHome(animated: false) : routeToOnboarding()
    }
    
}

struct UserDefaultsStorage {
    @UserDefaultsBacked(key: "isOnboardingCompleted", defaultValue: false)
    static var isOnboardingCompleted: Bool
}
