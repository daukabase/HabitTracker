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
    
    var onProgress: BoolClosure?
    
    // MARK: - Views
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var doneButton: DoneHabitButton!
    @IBOutlet private var progressIndicatorLabel: UILabel!
    @IBOutlet private var progressView: UIProgressView!
    @IBOutlet private var iconImageView: UIImageView!
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
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupProgressViewLayer()
    }
    
    // MARK: - Methods
    
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
    
}

extension HabitCell: ConfigurableCell {
    
    // MARK: - Configureable
    func configure(using viewModel: ConfigurableCellViewModel) {
        guard let viewModel = viewModel as? HabitCellViewModel else {
            return
        }
        
        titleLabel.text = viewModel.title
        
        progressIndicatorLabel.attributedText = viewModel.progressAttributedText
        iconImageView.image = viewModel.coloredImage
        
        progressView.setProgress(viewModel.progress, animated: true)
        progressView.trackTintColor = viewModel.color.withAlphaComponent(0.15)
        progressView.progressTintColor = viewModel.color
            
        doneButton.configure(color: viewModel.color)
        doneButton.isSelected = viewModel.isCheckpointForTodayCompleted
        
        viewModel.onProgressUpdate = { [weak viewModel, weak self] in
            guard let viewModel = viewModel else {
                return
            }
            self?.progressIndicatorLabel.attributedText = viewModel.progressAttributedText
            self?.progressView.setProgress(viewModel.progress, animated: true)
        }
        doneButton.onClick = { [weak viewModel] isSelected in
            viewModel?.set(isSelected: isSelected)
        }
    }
    
}
