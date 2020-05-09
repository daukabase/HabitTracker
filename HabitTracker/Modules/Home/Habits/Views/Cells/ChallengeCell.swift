//
//  ChallengeCell.swift
//  HabitTracker
//
//  Created by Daulet on 5/8/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

final class ChallengeCell: UITableViewCell {
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var progressIndicatorLabel: UILabel!
    @IBOutlet private var progressView: UIProgressView!
    @IBOutlet private var iconImageView: UIImageView!
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var askMarkContainerView: UIView!
    @IBOutlet private var askMarkButton: UIButton!
    @IBOutlet private var markDoneContainerView: UIView!
    @IBOutlet private var markDoneButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        clipsToBounds = false
        contentView.clipsToBounds = false
        let buttonShadowColor = UIColor(red: 254/255,
                                        green: 128/255,
                                        blue: 92/255,
                                        alpha: 0.24)
        
        askMarkButton.apply(style: .orange)
        askMarkContainerView.layer.backgroundColor = UIColor.clear.cgColor
        askMarkContainerView.applyDropShadow(color: buttonShadowColor,
                                      opacity: 1,
                                      offset: CGSize(width: 0, height: 4),
                                      radius: 20,
                                      scale: true)
        
        markDoneButton.apply(style: .orange)
        markDoneContainerView.layer.backgroundColor = UIColor.clear.cgColor
        markDoneContainerView.applyDropShadow(color: buttonShadowColor,
                                              opacity: 1,
                                              offset: CGSize(width: 0, height: 4),
                                              radius: 20,
                                              scale: true)
        
        iconImageView.roundCorners(.allCorners, radius: iconImageView.frame.height / 2)
        
        containerView.layer.backgroundColor = UIColor.clear.cgColor
        containerView.applyDropShadow()//color: UIColor.black.withAlphaComponent(0.06),
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
    
    func configure(model: Challenge) {
        titleLabel.text = model.title
        progressIndicatorLabel.attributedText = model.completionAttributedText
        iconImageView.image = model.image.filled(with: model.color)
        
        progressView.setProgress(model.progress, animated: true)
        progressView.trackTintColor = model.color.withAlphaComponent(0.15)
        progressView.progressTintColor = model.color
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
    
    @IBAction
    private func askMarkButtonClicked() {
        
    }
    
    @IBAction
    private func markDoneButtonClicked() {
        
    }
    
}
