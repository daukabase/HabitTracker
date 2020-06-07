//
//  DoneHabitCell.swift
//  HabitTracker
//
//  Created by Daulet on 5/8/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

final class DoneHabitCell: UITableViewCell {
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var doneButton: DoneHabitButton!
    @IBOutlet private var progressIndicatorLabel: UILabel!
    @IBOutlet private var progressView: UIProgressView!
    @IBOutlet private var iconImageView: UIImageView!
    @IBOutlet private var containerView: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        clipsToBounds = false
        contentView.clipsToBounds = false
        iconImageView.roundCorners(.allCorners, radius: iconImageView.frame.height / 2)
        
        containerView.layer.backgroundColor = UIColor.clear.cgColor
        containerView.applyDropShadow()
//        containerView.applyDropShadow(color: UIColor.black.withAlphaComponent(0.06),
//                                      opacity: 1,
//                                      offset: CGSize(width: 0, height: 4),
//                                      radius: 26,
//                                      scale: true)
        
        setupProgressViewLayer()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupProgressViewLayer()
    }
    
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
            guard let model = model else {
                return
            }
            if isSelected {
                model.done()
            } else {
                model.undone()
            }
            self?.progressIndicatorLabel.attributedText = model.completionAttributedText
            self?.progressView.setProgress(model.progress, animated: true)
        }
    }
    
    private func setupProgressViewLayer() {
        setupProgressIndicatorLayer()
        
        let maskLayerPath = UIBezierPath(roundedRect: progressView.bounds, cornerRadius: 6)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = progressView.bounds
        maskLayer.path = maskLayerPath.cgPath
        progressView.layer.mask = maskLayer
        progressView.layoutIfNeeded()
    }
    
    private func setupProgressIndicatorLayer() {
        progressView.layer.sublayers?[safe: 1]?.cornerRadius = 4
        progressView.subviews[safe: 1]?.clipsToBounds = true
    }
    
}
