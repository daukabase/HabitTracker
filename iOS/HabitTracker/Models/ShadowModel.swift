//
//  ShadowModel.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 7/26/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

struct ShadowModel {
    let color: CGColor
    let opacity: Float
    let offset: CGSize
    let radius: CGFloat
    let scale: Bool
    
    init(color: UIColor = .black,
         opacity: Float = 0.1,
         offset: CGSize = CGSize(width: 0, height: 5),
         radius: CGFloat = 10,
         scale: Bool = true) {
        self.color = color.cgColor
        self.opacity = opacity
        self.offset = offset
        self.radius = radius
        self.scale = scale
    }
    
}

extension ShadowModel {
    static let blueButton = ShadowModel(color: ColorName.uiBlue.color.withAlphaComponent(0.3),
                                        opacity: 1,
                                        offset: CGSize(width: 0, height: 4),
                                        radius: 20,
                                        scale: true)
}
