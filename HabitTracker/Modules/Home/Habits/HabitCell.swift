//
//  HabitCell.swift
//  HabitTracker
//
//  Created by Daulet on 4/25/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

final class HabitCell: UITableViewCell {

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var daysLeftLabel: UILabel!
    @IBOutlet private var progressIndicatorLabel: UILabel!
    @IBOutlet private var progressView: UIProgressView!
    @IBOutlet private var backgroundImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundImageView.roundCorners(.allCorners, radius: 24)
        setupProgressViewLayer()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupProgressViewLayer()
    }
    
    func configure(model: Habit) {
        let indicatorValue = NSMutableAttributedString()
        let first: [StringAttribute] = [
            .font(FontFamily.Gilroy.semibold.font(size: 18)),
            .foregroundColor(ColorName.uiWhite.color)
        ]
        let second: [StringAttribute] = [
            .font(FontFamily.Gilroy.semibold.font(size: 12)),
            .foregroundColor(ColorName.uiWhite.color)
        ]
        
        let firstText = "\(model.completedRepetitions)".with(attributes: first)
        let secondText = "/\(model.totalRepetitions)".with(attributes: second)
        
        indicatorValue.append(firstText)
        indicatorValue.append(secondText)
        
        titleLabel.text = model.title
        daysLeftLabel.text = "\(model.daysLeft) days left"
        progressIndicatorLabel.attributedText = indicatorValue
        backgroundImageView.image = model.backgroundImage
    }
    
    private func setupProgressViewLayer() {
        let maskLayerPath = UIBezierPath(roundedRect: progressView.bounds, cornerRadius: 6)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = progressView.bounds
        maskLayer.path = maskLayerPath.cgPath
        progressView.layer.mask = maskLayer
        progressView.layoutIfNeeded()
    }
    
}
