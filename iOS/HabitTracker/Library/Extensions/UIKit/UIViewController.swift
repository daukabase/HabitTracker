//
//  UIViewController.swift
//  Unicredit
//
//  Created by Anatoly Cherkasov on 20/02/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

extension UIViewController {

    // MARK: - Nested types

    enum NavigationItemStyle {
        case light
        case dark
        case orange
    }

    // MARK: - Internal methods

    func setupNavigation() {
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = ColorName.uiBlue.color
        navigationController?.navigationBar.roundCorners([.bottomLeft, .bottomRight], radius: 24)
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: FontFamily.Gilroy.medium.font(size: 24)!,
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        setNeedsStatusBarAppearanceUpdate()
    }
    
    func setBackButton(style: NavigationItemStyle) {
        let index = (navigationController?.viewControllers.count ?? 0) - 2

        if index < 0 {
            return
        }

        let backItem = UIBarButtonItem()
        backItem.title = ""

        switch style {
        case .light:
            backItem.tintColor = ColorName.uiWhite.color
        case .dark:
            backItem.tintColor = ColorName.textBlack.color
        case .orange:
            backItem.tintColor = ColorName.uiOrange.color
        }

        let targetViewController = navigationController?.viewControllers[safe: index]
        targetViewController?.navigationItem.backBarButtonItem = backItem
    }
    
    // Установить NavigationController для UIViewController
    open func wrapToNavigationController() -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: self)
        navigationController.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: FontFamily.Gilroy.medium.font(size: 24)!,
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]

        return navigationController
    }
    
    func heightNavigationBlock() -> CGFloat {
        let navigationBarHeight = (navigationController?.navigationBar.frame.height ?? 0)
        let height = UIApplication.shared.statusBarFrame.height + navigationBarHeight
        return height
    }

    func heightTabbarBlock() -> CGFloat {
        let tabBarHeight = (tabBarController?.tabBar.bounds.height ?? 0)
        return tabBarHeight
    }

    func configureExtendedLayout() {
        // This is important
        extendedLayoutIncludesOpaqueBars = true
        // Crunch for opaque tab bar and extendedLayoutIncludesOpaqueBars
        edgesForExtendedLayout = [.top, .left, .right]
    }
}
