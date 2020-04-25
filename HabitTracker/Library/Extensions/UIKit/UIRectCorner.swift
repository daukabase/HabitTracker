//
//  UIRectCorner.swift
//  Unicredit
//
//  Created by Ivan Smetanin on 01/03/2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

extension UIRectCorner {

    var caCornerMaskValue: CACornerMask {
        var mask: CACornerMask = []
        if contains(.bottomLeft) {
            mask = mask.union(.layerMinXMaxYCorner)
        }
        if contains(.bottomRight) {
            mask = mask.union(.layerMaxXMaxYCorner)
        }
        if contains(.topRight) {
            mask = mask.union(.layerMinXMinYCorner)
        }
        if contains(.topLeft) {
            mask = mask.union(.layerMaxXMinYCorner)
        }
        if contains(.allCorners) {
            mask = mask.union([.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner])
        }
        return mask
    }

}
