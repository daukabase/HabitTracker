//
//  ColorButton.swift
//  HabitTracker
//
//  Created by Daulet on 5/9/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

final class ColorButton: UIButton {
    
    var onClick: Closure<HabitColor>?
    
    var size: CGFloat = 32
    private(set) var habitColor = HabitColor.default
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        pin.width(frame.height)
        layer.cornerRadius = frame.height / 2
    }
    
    override func backgroundRect(forBounds bounds: CGRect) -> CGRect {
        let inset = (frame.width - size) / 2
        return super
            .backgroundRect(forBounds: bounds)
            .inset(by: UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset))
    }
    
    func commonInit() {
        clipsToBounds = true
        
        addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }
    
    func configure(habitColor: HabitColor) {
        self.habitColor = habitColor
        
        let color = habitColor.color
        let circle = UIImage.circle(diameter: size, borderColor: color, fillColor: color)
        let doneImage = UIImage.imageByCombiningImage(
            firstImage: UIImage.circle(diameter: size, borderColor: color, fillColor: color),
            withImage: Asset.doneNormal.image.resizedTo(size: CGSize(width: 14, height: 11))
        )
        
        setBackgroundImage(circle, for: .normal)
        setBackgroundImage(doneImage, for: .selected)
    }
    
    @objc func didTap() {
        onClick?(habitColor)
    }
    
}
