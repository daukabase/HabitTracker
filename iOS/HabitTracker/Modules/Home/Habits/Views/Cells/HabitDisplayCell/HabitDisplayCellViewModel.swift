//
//  HabitDisplayCellViewModel.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 12/20/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

class HabitDisplayCellViewModel: ConfigurableCellViewModel {
    
    // MARK: - ConfigurableCellViewModel
    var cellType: CellType = .habitInfo
    
    // MARK: - Callbacks
    var onProgressUpdate: EmptyClosure?
    
    // MARK: - Constants
    let color: UIColor
    let coloredImage: UIImage
    let title: String
    let habit: Habit
    
    // MARK: - Computed Properties
    var progressAttributedText: NSAttributedString {
        let indicatorValue = NSMutableAttributedString()
        
        let first: [StringAttribute] = [
            .font(FontFamily.Gilroy.semibold.font(size: 18)),
            .foregroundColor(color)
        ]
        let second: [StringAttribute] = [
            .font(FontFamily.Gilroy.regular.font(size: 12)),
            .foregroundColor(color)
        ]
        
        let firstText = "\(habit.completedRepetitions)".with(attributes: first)
        let secondText = "/\(habit.totalRepetitions)".with(attributes: second)
        
        [firstText, secondText].forEach(indicatorValue.append)
        
        return indicatorValue
    }
    
    var progress: Float {
        guard habit.totalRepetitions != 0 else {
            return 0
        }
        return Float(habit.completedRepetitions) / Float(habit.totalRepetitions)
    }
    
    // MARK: Init
    init(habit: Habit) {
        self.habit = habit
        self.title = habit.title
        self.color = habit.color
        self.coloredImage = habit.image.filled(with: color)
    }
    
}
