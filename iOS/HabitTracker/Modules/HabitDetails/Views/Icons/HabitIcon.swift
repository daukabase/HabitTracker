//
//  HabitIcon.swift
//  HabitTracker
//
//  Created by Daulet on 5/9/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation
import UIKit

enum HabitIcon: String, CaseIterable {
    case running, meditation, sleep, ride, apple, dance, drink, eat, read, swim, walk, workout
    
    init(rawValue: String, of defaultValue: HabitIcon = .meditation) {
        self = HabitIcon.init(rawValue: rawValue) ?? defaultValue
    }
}

extension HabitIcon {
    
    var icon: UIImage {
        switch self {
        case .apple:
            return Asset.apple.image
        case .dance:
            return Asset.dance.image
        case .drink:
            return Asset.drink.image
        case .running:
            return Asset.running.image
        case .meditation:
            return Asset.meditation.image
        case .sleep:
            return Asset.sleep.image
        case .ride:
            return Asset.ride.image
        case .eat:
            return Asset.eat.image
        case .read:
            return Asset.read.image
        case .swim:
            return Asset.swim.image
        case .walk:
            return Asset.walk.image
        case .workout:
            return Asset.workout.image
        }
    }
    
}
