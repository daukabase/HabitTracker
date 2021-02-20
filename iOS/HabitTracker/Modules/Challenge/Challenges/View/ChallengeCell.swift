//
//  ChallengeCell.swift
//  HabitTracker
//
//  Created by Daulet on 5/8/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

final class ChallengeCell: ShrinkableCell {
    
    weak var delegate: ChallengeDelegate?
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var progressIndicatorLabel: UILabel!
    @IBOutlet private var progressView: RoundedProgressView!
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
        containerView.applyDropShadow()
    }
    
    func configure(model: Challenge) {
        titleLabel.text = model.title
        iconImageView.image = model.image.filled(with: model.color)
        
        progressView.trackTintColor = model.color.withAlphaComponent(0.15)
        progressView.progressTintColor = model.color
    }
    
    @IBAction
    private func askMarkButtonClicked() {
        delegate?.askMark()
    }
    
    @IBAction
    private func markDoneButtonClicked() {
        delegate?.markAsDone()
    }
    
}
