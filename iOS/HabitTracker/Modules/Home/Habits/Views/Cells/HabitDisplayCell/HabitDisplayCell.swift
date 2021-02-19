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
    @IBOutlet private var progressView: RoundedProgressView!
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
    }
    
}

extension HabitDisplayCell: ConfigurableCell {
    
    // MARK: - ConfigurableCell
    func configure(using viewModel: ConfigurableCellViewModel) {
        guard let viewModel = viewModel as? HabitDisplayCellViewModel else {
            return
        }
        titleLabel.text = viewModel.title
        
        progressIndicatorLabel.attributedText = viewModel.progressAttributedText(color: viewModel.color)
        iconImageView.image = viewModel.coloredImage
        
        progressView.setProgress(viewModel.progress, animated: true)
        progressView.trackTintColor = viewModel.color.withAlphaComponent(0.15)
        progressView.progressTintColor = viewModel.color
    }
    
}
