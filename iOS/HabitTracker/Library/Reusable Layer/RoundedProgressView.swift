//
//  RoundedProgressView.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 2/20/21.
//  Copyright © 2021 Daulet. All rights reserved.
//

import UIKit

class RoundedProgressView: UIProgressView {
    
    // MARK: - Constants
    private enum Constants {
        static let progressViewHeight: CGFloat = 12
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commmonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commmonInit()
    }
    
    // MARK: - UIProgressView
    override func awakeFromNib() {
        super.awakeFromNib()
//        commmonInit()
    }
    
    // MARK: - Private Methods
    private func commmonInit() {
        snp.makeConstraints { make in
            make.height.equalTo(Constants.progressViewHeight)
        }
        setupProgressViewLayer()
    }
    
    private func setupProgressViewLayer() {
        layer.cornerRadius = Constants.progressViewHeight / 2
        clipsToBounds = true
        
        setupProgressIndicatorLayer()
    }
    
    private func setupProgressIndicatorLayer() {
        layer.sublayers?[safe: 1]?.cornerRadius = 6
        subviews[safe: 1]?.clipsToBounds = true
    }
    
}
