//
//  UIStackView.swift
//  Unicredit
//
//  Created by Ivan Smetanin on 14/03/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

extension UIStackView {

    func removeAllArrangedSubviews() {
        arrangedSubviews.forEach {
            removeArrangedSubview($0)
            NSLayoutConstraint.deactivate($0.constraints)
            $0.removeFromSuperview()
        }
    }

}
