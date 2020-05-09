//
//  IconCellViewModel.swift
//  HabitTracker
//
//  Created by Daulet on 5/9/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

class IconCellViewModel {
    
    let defaultColor = ColorName.icons.color
    
    var isSelected: Bool = false
    var selectedColor: UIColor
    var habitIcon: HabitIcon
    
    init(isSelected: Bool, selectedColor: UIColor, habitIcon: HabitIcon) {
        self.isSelected = isSelected
        self.selectedColor = selectedColor
        self.habitIcon = habitIcon
    }
    
}
