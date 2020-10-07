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

    enum SwitchStyle {
        case `default`
    }

    // MARK: - Internal methods

    func apply(style: SwitchStyle = .default) {
        switch style {
        case .default:
            applyDefaultStyle()
        }
    }

    // MARK: - Private methods

    private func applyDefaultStyle() {
        onTintColor = ColorName.uiBlue.color
        backgroundColor = ColorName.uiBlueSecondary.color
        tintColor = ColorName.uiBlueSecondary.color
        layer.cornerRadius = frame.height / 2
    }

}
