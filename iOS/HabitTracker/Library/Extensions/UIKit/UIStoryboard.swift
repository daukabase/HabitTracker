//
//  UIStoryboard.swift
//  Unicredit
//
//  Created by Anatoly Cherkasov on 06/02/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

extension UIStoryboard {

    /// Instant Initial View Controller of the same storyboard name
    static func instantiate<ViewController: UIViewController>(ofType: ViewController.Type) -> ViewController? {
        let storyboard = UIStoryboard(name: String(describing: ViewController.self), bundle: Bundle.main)
        return storyboard.instantiateInitialViewController() as? ViewController
    }

}
