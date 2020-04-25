//
//  UITabBar.swift
//  Unicredit
//
//  Created by Ivan Smetanin on 31/01/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

extension UITabBar {

    enum Style {
        case standard
    }

    func apply(style: Style) {
        tintColor = Color.TabBar.tint
        unselectedItemTintColor = Color.TabBar.tintUnselected
        barTintColor = .white
    }

}
