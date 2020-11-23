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
    func configure(model: Habit) {
        titleLabel.text = model.title
        progressIndicatorLabel.attributedText = model.completionAttributedText
        iconImageView.image = model.image.filled(with: model.color)
        
        progressView.setProgress(model.progress, animated: true)
        progressView.trackTintColor = model.color.withAlphaComponent(0.15)
        progressView.progressTintColor = model.color
        
        doneButton.configure(color: model.color)
        doneButton.isSelected = model.isCurrentCompleted
        
        doneButton.onClick = { [weak model, weak self] isSelected in
            Haptic.impact(.heavy).generate()
            guard let model = model, let checkpoint = model.checkpoint else {
                return
            }
            let block = {
                model.updateGoal {
                    self?.progressIndicatorLabel.attributedText = model.completionAttributedText
                    self?.progressView.setProgress(model.progress, animated: true)
                }
            }
            if isSelected {
                HabitStorage.setDone(checkpoint: checkpoint) { isSucceed in
                    guard isSucceed else { return }
                    block()
                }
            } else {
                HabitStorage.setUndone(checkpoint: checkpoint) { isSucceed in
                    guard isSucceed else { return }
                    block()
                }
            }
            
        }
    }
    
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
