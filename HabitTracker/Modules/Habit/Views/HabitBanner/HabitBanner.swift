//
//  HabitBanner.swift
//  HabitTracker
//
//  Created by Daulet on 5/10/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

final class HabitBanner: UIView {

    @IBOutlet private var containerView: UIView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        initFromNib()
        
        containerView.layer.backgroundColor = UIColor.clear.cgColor
        containerView.applyDropShadow()
        backgroundColor = .clear
    }
    
    func setup(model: HabitBannerViewModel) {
        self.titleLabel.text = model.titleText
        self.descriptionLabel.attributedText = model.descriptionAttributed
    }
    
}
