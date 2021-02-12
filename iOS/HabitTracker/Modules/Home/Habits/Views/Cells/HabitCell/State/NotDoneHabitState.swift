//
//  NotDoneHabitState.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 2/12/21.
//  Copyright © 2021 Daulet. All rights reserved.
//

import UIKit

final class NotDoneHabitState: HabitAbstractCellState {
    
    override func setDone(viewModel: HabitCellViewModel?) {
        guard let viewModel = viewModel else { return }
        
        cell.progressIndicatorLabel.attributedText = viewModel.progressAttributedText(color: viewModel.color)
        
        UIView.animate(withDuration: 0.5) {
            self.setupUI(using: viewModel)
            self.cell.layoutIfNeeded()
        }
        
        cell.changeState(state: DoneHabitState(cell: cell))
    }
    
    private func setupUI(using viewModel: HabitCellViewModel) {
        cell.progressView.trackTintColor = viewModel.color.withAlphaComponent(0.15)
        cell.progressView.progressTintColor = viewModel.color
        
        cell.progressView.setProgress(viewModel.progress, animated: true)
        
        cell.doneButton.configure(color: viewModel.color)
        cell.doneButton.isSelected = true
        
        cell.iconImageView.image = viewModel.coloredImage
    }
    
}
