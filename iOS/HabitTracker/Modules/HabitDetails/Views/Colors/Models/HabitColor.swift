//
//  HabitColor.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 12/11/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

enum HabitColor: CaseIterable {
    
    static let `default` = HabitColor.red
    
    case red
    case skyBlue
    case violet
    case green
    case yellow
    case habitBlue
    
    var color: UIColor {
        switch self {
        case .red:
            return ColorName.uiRed.color
        case .skyBlue:
            return ColorName.uiSkyBlue.color
        case .violet:
            return ColorName.uiViolet.color
        case .green:
            return ColorName.uiGreen.color
        case .yellow:
            return ColorName.uiYellow.color
        case .habitBlue:
            return ColorName.uiHabitBlue.color
        }
    }
    
}
