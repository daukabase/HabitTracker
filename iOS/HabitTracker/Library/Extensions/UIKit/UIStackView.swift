//
//  UIStackView.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 12/21/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

extension UIStackView {

    public func removeAllArrangedSubviews() {
        arrangedSubviews.forEach {
            removeArrangedSubview($0)
            $0.removeFromSuperview()
            
            NSLayoutConstraint.deactivate($0.constraints)
        }
    }
    
}
