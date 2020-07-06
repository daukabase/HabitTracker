//
//  HabitTitleView.swift
//  HabitTracker
//
//  Created by Daulet on 7/6/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

final class HabitTitleView: UIView {
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var imageView: UIImageView!
    
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
    }
    
    func setup(title: String?, image: UIImage?, color: UIColor) {
        self.titleLabel.text = title
        self.imageView.image = image?.filled(with: color)
    }
    
}
