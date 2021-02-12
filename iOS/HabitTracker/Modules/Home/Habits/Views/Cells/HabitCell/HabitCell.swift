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
    
    typealias State = HabitAbstractCellState
    
    // MARK: - Properties
    var onProgress: BoolClosure?
    
    private lazy var state: State = NotDoneHabitState(cell: self)
    private weak var model: HabitCellViewModel?
    
    // MARK: - Views
    @IBOutlet internal var titleLabel: UILabel!
    @IBOutlet internal var doneButton: DoneHabitButton!
    @IBOutlet internal var progressIndicatorLabel: UILabel!
    @IBOutlet internal var progressView: UIProgressView!
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
        
        setupProgressViewLayer()
        
        doneButton.onClick = { [weak self] isSelected in
            self?.onChange(isSelected: isSelected)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupProgressViewLayer()
    }
    
    // MARK: - Internal Methods
    func changeState(state: State) {
        self.state = state
    }
    
    // MARK: - Private Methods
    private func setupProgressViewLayer() {
        setupProgressIndicatorLayer()
        
        let maskLayerPath = UIBezierPath(roundedRect: progressView.bounds, cornerRadius: progressView.frame.height / 2)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = progressView.bounds
        maskLayer.path = maskLayerPath.cgPath
        progressView.layer.mask = maskLayer
        progressView.layoutIfNeeded()
    }
    
    private func setupProgressIndicatorLayer() {
        progressView.layer.sublayers?[safe: 1]?.cornerRadius = progressView.frame.height / 2
        progressView.subviews[safe: 1]?.clipsToBounds = true
    }
    
    private func onChange(isSelected: Bool) {
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


class HabitAbstractCellState {
    
    let cell: HabitCell
    
    init(cell: HabitCell) {
        self.cell = cell
    }
    
    func setDone(viewModel: HabitCellViewModel?) {
        
    }
    
    func setUndone(viewModel: HabitCellViewModel?) {
        
    }
    
}

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
