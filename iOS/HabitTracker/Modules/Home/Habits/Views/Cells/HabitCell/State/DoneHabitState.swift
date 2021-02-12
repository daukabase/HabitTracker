//
//  DoneHabitState.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 2/12/21.
//  Copyright © 2021 Daulet. All rights reserved.
//

import UIKit

final class DoneHabitState: HabitAbstractCellState {
    
    private let grayColor = ColorName.uiGraySecondary.color
    
    override func setUndone(viewModel: HabitCellViewModel?) {
        guard let viewModel = viewModel else { return }
        
        cell.progressIndicatorLabel.attributedText = viewModel.progressAttributedText(color: grayColor)
        
        UIView.animate(withDuration: 0.5) {
            self.setupUI(using: viewModel)
            self.cell.layoutIfNeeded()
        }
        
        cell.changeState(state: NotDoneHabitState(cell: cell))
    }
    
    private func setupUI(using viewModel: HabitCellViewModel) {
        cell.progressView.trackTintColor = grayColor.withAlphaComponent(0.15)
        cell.progressView.progressTintColor = grayColor
        
        cell.progressView.setProgress(viewModel.progress, animated: true)
        
        cell.doneButton.configure(color: grayColor)
        cell.doneButton.isSelected = false
        
        cell.iconImageView.image = viewModel.image.filled(with: grayColor)
    }
    
}
