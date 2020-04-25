//
//  UISwitch.swift
//  Unicredit
//
//  Created by Ivan Smetanin on 01/02/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

extension UISwitch {

    // MARK: - Nested types

    enum Style {
        case `default`
    }

    // MARK: - Internal methods

    func apply(style: Style) {
        switch style {
        case .default:
            applyDefaultStyle()
        }
    }

    // MARK: - Private methods

    private func applyDefaultStyle() {
        onTintColor = Color.Main.blue
        backgroundColor = Color.Main.graySeparator
        cornerRadius = 16
    }

}
