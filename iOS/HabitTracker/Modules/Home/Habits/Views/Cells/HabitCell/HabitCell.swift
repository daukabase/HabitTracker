//
//  DoneHabitCell.swift
//  HabitTracker
//
//  Created by Daulet on 5/8/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit
import Haptica

final class HabitCell: ShrinkableCell {
    
    private enum Constansts {
        static let progressViewHeight: CGFloat = 12
    }
    
    typealias State = HabitAbstractCellState
    
    // MARK: - Properties
    var onProgress: BoolClosure?
    
    private lazy var state: State = NotDoneHabitState(cell: self)
    private weak var model: HabitCellViewModel?
    
    // MARK: - Views
    @IBOutlet internal var titleLabel: UILabel!
    @IBOutlet internal var doneButton: DoneHabitButton!
    @IBOutlet internal var progressIndicatorLabel: UILabel!
    @IBOutlet internal var progressView: RoundedProgressView!
    @IBOutlet internal var iconImageView: UIImageView!
    @IBOutlet private var containerView: UIView!
    
    // MARK: - Superview
    override func awakeFromNib() {
        super.awakeFromNib()
        
        clipsToBounds = false
        contentView.clipsToBounds = false
        iconImageView.roundCorners(.allCorners, radius: iconImageView.frame.height / 2)
        
        containerView.layer.backgroundColor = UIColor.clear.cgColor
        containerView.applyDropShadow()
        
        doneButton.onClick = { [weak self] isSelected in
            self?.doneButtonDidClicked(isSelected: isSelected)
        }
    }
    
    // MARK: - Internal Methods
    func changeState(state: State) {
        self.state = state
    }
    
    // MARK: - Private Methods
    private func doneButtonDidClicked(isSelected: Bool) {
        Haptic.impact(.medium).generate()
        
        model?.set(isSelected: isSelected) { [weak self] in
            self?.makeAction(for: isSelected)
        }
    }
    
    private func makeAction(for isSelected: Bool) {
        if isSelected {
            state.setDone(viewModel: model)
        } else {
            state.setUndone(viewModel: model)
        }
    }
    
    private func setState(isSelected: Bool) {
        if isSelected {
            state = NotDoneHabitState(cell: self)
        } else {
            state = DoneHabitState(cell: self)
        }
        makeAction(for: isSelected)
        self.setNeedsLayout()
    }
    
}

extension HabitCell: ConfigurableCell {
    
    // MARK: - Configureable
    func configure(using viewModel: ConfigurableCellViewModel) {
        guard let viewModel = viewModel as? HabitCellViewModel else {
            return
        }
        self.model = viewModel
        
        titleLabel.text = viewModel.title
        setState(isSelected: viewModel.isCheckpointForTodayCompleted)
    }
    
}
