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

    enum NavigationBarStyle {
        case light
        case blue
        
        fileprivate var barTintColor: UIColor {
            switch self {
            case .light:
                return ColorName.uiWhite.color
            case .blue:
                return ColorName.uiBlue.color
            }
        }
        
        fileprivate var titleTextAttributes: [NSAttributedString.Key: Any] {
            var attributes: [NSAttributedString.Key: Any] = [
                NSAttributedString.Key.font: FontFamily.Gilroy.medium.font(size: 18)!
            ]
            
            switch self {
            case .light:
                attributes[NSAttributedString.Key.foregroundColor] = ColorName.textBlack.color
            case .blue:
                attributes[NSAttributedString.Key.foregroundColor] = ColorName.uiWhite.color
            }
            
            return attributes
        }
    }

    // MARK: - Internal methods

    func setupNavigation(style: NavigationBarStyle) {
        navigationController?.view.backgroundColor = .clear
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = style.barTintColor
        navigationController?.navigationBar.tintColor = ColorName.uiGrayPrimary.color
        navigationController?.navigationBar.titleTextAttributes = style.titleTextAttributes
        
        setNeedsStatusBarAppearanceUpdate()
    }
    
    func setBackButton(style: NavigationItemStyle) {
        let index = (navigationController?.viewControllers.count ?? 0) - 2

        if index < 0 {
            return
        }

        let backItem = UIBarButtonItem()
        backItem.title = ""
        backItem.accessibilityIdentifier = "Navbar Back"
        
        if #available(iOS 14.0, *) {
            backItem.menu = nil
        }
        
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
