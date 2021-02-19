//
//  MainTabBarController.swift
//  MoveOn
//  Created by Daulet on 08/02/2019.
//  Copyright © 2019 daukabase. All rights reserved.
//

import UIKit

final class MainTabBarController: UITabBarController {

    // MARK: - UITabBarController
    override var childForStatusBarStyle: UIViewController? {
        let selected = self.viewControllers?[self.selectedIndex]
        return (selected as? UINavigationController)?.topViewController ?? selected
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonInit()
    }

    // MARK: - Privatet Methods
    private func commonInit() {
        delegate = self
        tabBar.isTranslucent = false
        tabBar.tintColor = ColorName.uiBlue.color
        tabBar.unselectedItemTintColor = ColorName.uiGraySecondary.color
        
        let tabs: [Tab] = [.habit, .challenge, .settings]
        viewControllers = tabs.map { $0.viewController }
    }
    
}

// MARK: - UITabBarControllerDelegate

extension MainTabBarController: UITabBarControllerDelegate {

    func tabBarController(_: UITabBarController, didSelect viewController: UIViewController) {
        
    }

    func tabBarController(_ tabBarController: UITabBarController,
                          shouldSelect viewController: UIViewController) -> Bool {
        
        return true
    }

}
