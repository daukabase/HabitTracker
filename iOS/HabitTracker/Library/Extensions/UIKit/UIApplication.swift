//
//  UIApplication.swift
//  Unicredit
//
//  Created by Ivan Smetanin on 31/01/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

extension UIApplication {

    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }

    class func topViewController(
        _ controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController
    ) -> UIViewController? {

        if let navigationController = controller as? UINavigationController {
            return topViewController(navigationController.visibleViewController)
        }

        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(selected)
            }
        }

        if let presented = controller?.presentedViewController {
            return topViewController(presented)
        }

        return controller
    }

    func openApplicationSettings() {
        guard
            let url = URL(string: UIApplication.openSettingsURLString),
            UIApplication.shared.canOpenURL(url)
        else {
            return
        }
        UIApplication.shared.open(url)
    }

}
