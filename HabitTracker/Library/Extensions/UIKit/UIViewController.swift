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
    }

    // MARK: - Internal methods

    func setBackButton(style: NavigationItemStyle) {
        let index = (navigationController?.viewControllers.count ?? 0) - 2

        if index < 0 {
            return
        }

        let backItem = UIBarButtonItem()
        backItem.title = ""

        switch style {
        case .light:
            backItem.tintColor = Color.Main.white
        case .dark:
            backItem.tintColor = Color.Main.blackText
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

    func showOverlayLoading(animated: Bool = true, completion: EmptyClosure? = nil) {
        guard presentedViewController as? LoadingIndicatableOverlayViewController == nil else {
            return
        }
        let vc = LoadingIndicatableOverlayViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: animated, completion: {
            completion?()
        })
    }

    func hideOverlayLoading(animated: Bool = true, completion: EmptyClosure? = nil) {
        guard let presentedViewController = presentedViewController as? LoadingIndicatableOverlayViewController else {
            return
        }
        presentedViewController.dismiss(animated: animated, completion: {
            completion?()
        })
    }

    // MARK: - Customizing title

    func setTitle(item: LocalizableStringItem, style: NavigationItemStyle) {
        let labelTitle = UILabel()
        labelTitle.adjustsFontSizeToFitWidth = true
        labelTitle.font = FontFamily.UniCreditCY.medium.font(size: 18)
        labelTitle.localized = item

        switch style {
        case .light:
            labelTitle.textColor = Color.Main.white
        case .dark:
            labelTitle.textColor = Color.Main.blackText
        }

        navigationItem.titleView = labelTitle
    }

}
