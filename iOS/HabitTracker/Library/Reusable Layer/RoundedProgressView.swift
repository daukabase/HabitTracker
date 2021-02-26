//
//  RoundedProgressView.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 2/20/21.
//  Copyright © 2021 Daulet. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedProgressView: UIView {
    
    // MARK: - Constants
    private enum Constants {
        static let progressViewHeight: CGFloat = 12
        static let radius = progressViewHeight / 2
        static let minimumProgressWidth = progressViewHeight
    }
    
    // MARK: - Properties
    @IBInspectable var progressTintColor: UIColor? = .gray
    @IBInspectable var trackTintColor: UIColor? = .gray {
        didSet {
            self.backgroundColor = trackTintColor
        }
    }
    
    private(set) var progress: CGFloat = 0.5 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    private let progressLayer = CALayer()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.addSublayer(progressLayer)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        layer.addSublayer(progressLayer)
    }
    
    // MARK: - SuperView
    override func draw(_ rect: CGRect) {
        
        let backgroundMask = CAShapeLayer()
        backgroundMask.path = UIBezierPath(roundedRect: rect, cornerRadius: Constants.radius).cgPath
        layer.mask = backgroundMask
        
        var progressWidth: CGFloat = 0
        if progress != 0 {
            progressWidth = max(Constants.minimumProgressWidth, rect.width * progress)
        }
        
        
        let progressRect = CGRect(origin: .zero, size: CGSize(width: progressWidth, height: rect.height))
        progressLayer.frame = progressRect
        progressLayer.cornerRadius = Constants.radius
        progressLayer.backgroundColor = progressTintColor?.cgColor
    }
    
    // MARK: - Methods
    func setProgress(_ value: Float) {
        self.progress = CGFloat(value)
    }
    
}
