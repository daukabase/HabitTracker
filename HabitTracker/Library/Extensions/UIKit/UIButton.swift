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
        case orange
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
        case .orange:
            setOrangeStyle()
        }
    }

    // MARK: - Private methods

    private func setBlueStyle() {
        roundCorners(.allCorners, radius: 25)
        backgroundColor = .clear
        setTitleColor(ColorName.uiWhite.color, for: .normal)
        
        titleLabel?.font = FontFamily.Gilroy.medium.font(size: 16)
        let normalImage = UIImage.imageWithColor(ColorName.uiBlue.color)
        let disabledImage = UIImage.imageWithColor(ColorName.uiBlueSecondary.color)
        setBackgroundImage(normalImage, for: .normal)
        setBackgroundImage(disabledImage, for: .disabled)
    }

    private func setOrangeStyle() {
        roundCorners(.allCorners, radius: 25)
        backgroundColor = .clear
        setTitleColor(ColorName.uiWhite.color, for: .normal)
        
        titleLabel?.font = FontFamily.Gilroy.medium.font(size: 16)
        let normalImage = UIImage.imageWithColor(ColorName.uiOrange.color)
        setBackgroundImage(normalImage, for: .normal)
    }

}
