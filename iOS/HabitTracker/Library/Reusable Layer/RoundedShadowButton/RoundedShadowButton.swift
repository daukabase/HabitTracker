//
//  RoundedShadowButton.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 7/26/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

class RoundedShadowButton: UIButton {
    
    private var model: RoundedShadowButtonModel?

    convenience init(model: RoundedShadowButtonModel, frame: CGRect) {
        self.init(frame: frame)
            
        self.model = model
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        addShadow()
    }
    
    private func addShadow() {
        guard let model = model, !model.shadowAdded else {
            return
        }
        let shadowLayer = CAShapeLayer(shadowModel: model.shadowModel,
                                       owner: bounds,
                                       cornerRadius: model.radius,
                                       backgroundColor: model.backgroundColor)
        
        layer.insertSublayer(shadowLayer, at: 0)
        self.model?.shadowAdded = true
    }
    
}
