//
//  MainTabbar.Tab.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 2/20/21.
//  Copyright © 2021 Daulet. All rights reserved.
//

import UIKit

extension MainTabBarController {
    
    enum Tab: Int, CaseIterable {
        case habit
        case challenge
        case settings

        var title: String {
            switch self {
            case .habit:
                return "Habit"
            case .challenge:
                return "Challenge"
            case .settings:
                return "Settings"
            }
        }

        var image: UIImage? {
            switch self {
            case .habit:
                return nil
            case .challenge:
                return nil
            case .settings:
                return nil
            }
        }
        
        var item: UITabBarItem {
            let item = UITabBarItem()
            
            item.title = title
            item.image = image
            
            return item
        }
        
        var viewController: UIViewController {
            let controller = _viewController
            controller.tabBarItem = item
            return controller
        }
        
        private var _viewController: UIViewController {
            switch self {
            case .habit:
                return UINavigationController(rootViewController: HomeViewController())
            case .challenge:
                return UINavigationController(rootViewController: ChallengesViewController())
            case .settings:
                return UINavigationController(rootViewController: SettingsTableViewController())
            }
        }

        var selectedImage: UIImage? {
            return image
        }
    }

}
