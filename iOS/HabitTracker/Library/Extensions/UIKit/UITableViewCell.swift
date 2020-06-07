//
//  UITableViewCell.swift
//  Unicredit
//
//  Created by Anatoly Cherkasov on 09/04/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

extension UITableViewCell {

    func set(highlighted: Bool,
             highlightedColor: UIColor = ColorName.uiGrayPrimary.color,
             baseColor: UIColor = ColorName.uiWhite.color) {

        set(highlighted: highlighted,
            containerView: contentView,
            highlightedColor: highlightedColor,
            baseColor: baseColor)
    }

    func set(highlighted: Bool,
             containerView: UIView,
             highlightedColor: UIColor = ColorName.uiGrayPrimary.color,
             baseColor: UIColor = ColorName.uiWhite.color) {

        let color = highlighted ? highlightedColor : baseColor

        UIView.animate(withDuration: UIView.Constants.animationTime) {
            containerView.backgroundColor = color
        }
    }
}
