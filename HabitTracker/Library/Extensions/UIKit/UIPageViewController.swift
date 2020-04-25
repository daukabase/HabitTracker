//
//  UIPageViewController.swift
//  Unicredit
//
//  Created by Anatoly Cherkasov on 01/03/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

extension UIPageViewController {

    var scrollView: UIScrollView? {
        for subview in view.subviews {
            if let scrollView = subview as? UIScrollView {
                return scrollView
            }
        }
        return nil
    }

}
