//
//  PreferredNavigationController.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 2/22/21.
//  Copyright © 2021 Daulet. All rights reserved.
//

import UIKit

class PreferredNavigationController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if let lastViewController = viewControllers.last {
            // return the status property of each VC, look at step 2
            return lastViewController.preferredStatusBarStyle
        }
        return .default
    }

}
