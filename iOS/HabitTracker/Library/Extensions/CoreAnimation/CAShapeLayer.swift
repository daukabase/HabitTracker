//
//  CAShapeLayer.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 7/26/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

extension CAShapeLayer {
    
    convenience init(shadowModel: ShadowModel, owner bounds: CGRect, cornerRadius: CGFloat, backgroundColor: UIColor) {
        self.init()
        
        path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        fillColor = backgroundColor.cgColor
        shadowColor = shadowModel.color
        shadowPath = self.path
        shadowOffset = shadowModel.offset
        shadowOpacity = shadowModel.opacity
        shadowRadius = shadowModel.radius
    }
    
}
