//
//  UINavigationBar.swift
//  Unicredit
//
//  Created by Ivan Smetanin on 01/02/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

extension UINavigationBar {

    // MARK: - Nested types

    enum Style {
        case gray
        case dark
        case transparent
    }

    // MARK: - Internal methods

    func apply(style: Style, isLargeTitles: Bool = false) {
        switch style {
        case .gray:
            applyGrayStyle()
        case .dark:
            applyDarkStyle()
        case .transparent:
            applyTransparentStyle()
        }

        if isLargeTitles {
            applyLargeTitles()
        } else {
            disableLargeTitle()
        }
    }

    /// Sets shadow to navigationBar
    ///
    /// Add a backgroundColor only if your navigationBar
    /// is transparent to get the correct drop shadow.
    ///
    /// - Parameters:
    ///   - model: Shadow model
    ///   - backgroundColor: NavigationBar backgroundColor
    func set(shadow model: ShadowModel, with backgroundColor: UIColor = .clear) {
        if backgroundColor != .clear {
            self.backgroundColor = backgroundColor
        }
        applyDropShadow(with: model)
    }

    // MARK: - Private methods

    private func applyGrayStyle() {
        isTranslucent = false

        backgroundColor = Color.Main.grayBackground
        tintColor = Color.Main.blackText
        barTintColor = Color.Main.grayBackground

        backIndicatorImage = Asset.iconBackButton.image
        backIndicatorTransitionMaskImage = Asset.iconBackButton.image

        shadowImage = UIImage()
        setBackgroundImage(UIImage(), for: .default)
    }

    private func applyDarkStyle() {
        isTranslucent = false

        backgroundColor = Color.Main.blackBackground
        barTintColor = Color.Main.blackBackground
        tintColor = Color.Main.white

        backIndicatorImage = Asset.iconBackButton.image
        backIndicatorTransitionMaskImage = Asset.iconBackButton.image

        shadowImage = UIImage()
        setBackgroundImage(UIImage(), for: .default)
    }

    private func applyTransparentStyle() {
        isTranslucent = true

        backgroundColor = UIColor.clear
        barTintColor = Color.Main.white
        tintColor = Color.Main.white

        backIndicatorImage = Asset.iconBackButton.image
        backIndicatorTransitionMaskImage = Asset.iconBackButton.image

        shadowImage = UIImage()
        setBackgroundImage(UIImage(), for: .default)
    }

    private func applyLargeTitles() {
        isTranslucent = true
        prefersLargeTitles = true
    }

    private func disableLargeTitle() {
        prefersLargeTitles = false
    }

}
