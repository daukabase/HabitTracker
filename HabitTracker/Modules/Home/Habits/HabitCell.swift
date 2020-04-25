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
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupProgressViewLayer()
    }
    
    func configure(model: Habit) {
        titleLabel.text = model.title
        daysLeftLabel.text = "\(model.daysLeft) days left"
        let first = StringAttribute
        
        
        progressIndicatorLabel
    }
    
    private func setupProgressViewLayer() {
        let maskLayerPath = UIBezierPath(roundedRect: progressView.bounds, cornerRadius: 4.0)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = progressView.bounds
        maskLayer.path = maskLayerPath.cgPath
        progressView.layer.mask = maskLayer
    }
    
}
