//
//  UIButton.swift
//  Unicredit
//
//  Created by Ivan Smetanin on 31/01/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

extension UIButton {

    // MARK: - Nested types

    private enum Constants {
        static let defaultFontSize: CGFloat = 18
    }

    /// Provides default styles for button
    ///
    /// - blue: Sets cornerRadius, blue background color and light blue background color for disabled state.
    /// - roundedBorder: Sets cornerRadius, white background color and 1pt gray border.
    enum Style {
        case blue
        case roundedGrayBorder
        case white
    }

    // MARK: - Properties

    /// Wrapper on `title(for: normal)` and `setTitle(newValue, for: .normal)`
    var title: String? {
        get {
            return title(for: .normal)
        } set {
            setTitle(newValue, for: .normal)
        }
    }

    /// Wrapper on `titleColor(for: normal)` and `setTitleColor(newValue, for: .normal)`
    var titleColor: UIColor? {
        get {
            return titleColor(for: .normal)
        } set {
            setTitleColor(newValue, for: .normal)
        }
    }

    // MARK: - Internal methods

    func apply(style: Style) {
        clipsToBounds = true
        switch style {
        case .blue:
            setBlueStyle()
        case .roundedGrayBorder:
            setRoundedGrayBorderStyle()
        case .white:
            setWhiteStyle()
        }
    }

    // MARK: - Private methods

    private func setBlueStyle() {
        layer.cornerRadius = Constants.defaultCornerRadius
        backgroundColor = .clear
        setTitleColor(.white, for: .normal)
        titleLabel?.font = FontFamily.UniCreditCY.medium.font(size: Constants.defaultFontSize)
        let normalImage = UIImage.imageWithColor(Color.Main.blue)
        let disabledImage = UIImage.imageWithColor(Color.Main.blueLight)
        setBackgroundImage(normalImage, for: .normal)
        setBackgroundImage(disabledImage, for: .disabled)
    }

    private func setRoundedGrayBorderStyle() {
        layer.cornerRadius = Constants.defaultCornerRadius
        backgroundColor = .white
        setTitleColor(Color.Main.blackText, for: .normal)
        titleLabel?.font = FontFamily.UniCreditCY.medium.font(size: Constants.defaultFontSize)
        layer.borderWidth = 1
        layer.borderColor = Color.Main.graySeparator.cgColor
    }

    private func setWhiteStyle() {
        backgroundColor = .white
        setTitleColor(Color.Main.blackText, for: .normal)
        titleLabel?.font = FontFamily.UniCreditCY.medium.font(size: Constants.defaultFontSize)
    }

}
