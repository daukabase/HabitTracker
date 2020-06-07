//
//  UINavigationController.swift
//  Unicredit
//
//  Created by Ivan Smetanin on 18/06/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

extension UINavigationController {

    override open var preferredStatusBarStyle: UIStatusBarStyle {
        if let lastViewController = viewControllers.last {
            // return the status property of each VC, look at step 2
            return lastViewController.preferredStatusBarStyle
        }
        return .default
    }

}
