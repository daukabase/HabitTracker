//
//  HabitDisplayCell.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 12/20/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit
import Haptica

final class HabitDisplayCell: ShrinkableCell {
    
    // MARK: - Views
    @IBOutlet private var titleLabel: UILabel!
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

extension HabitDisplayCell: ConfigurableCell {
    
    func configure(using viewModel: ConfigurableCellViewModel) {
        guard let viewModel = viewModel as? HabitDisplayCellViewModel else {
            return
        }
        titleLabel.text = viewModel.title
        
    }
    
}
