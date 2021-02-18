//
//  DoneHabitButton.swift
//  HabitTracker
//
//  Created by Daulet on 5/8/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

final class DoneHabitButton: UIButton {
    
    var onClick: BoolClosure?
    
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
        
        layer.cornerRadius = frame.height / 2
    }
    
    override func backgroundRect(forBounds bounds: CGRect) -> CGRect {
        return super
            .backgroundRect(forBounds: bounds)
            .inset(by: UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12))
    }
    
    func commonInit() {
        clipsToBounds = true
        
        addTarget(self, action: #selector(didTap), for: .touchUpInside)
        
        snp.makeConstraints { make in
            make.width.equalTo(snp.height)
        }
    }
    
    func configure(color: UIColor) {
        let circle = UIImage.circle(diameter: 24, borderColor: color)
        
        let doneImage = UIImage.imageByCombiningImage(
            firstImage: UIImage.circle(diameter: 24, borderColor: color, fillColor: color),
            withImage: Asset.doneLittle.image
        )
        
        setBackgroundImage(circle, for: .normal)
        setBackgroundImage(doneImage, for: .selected)
        
        setNeedsLayout()
    }
    
    @objc func didTap() {
        isSelected.toggle()
        setNeedsLayout()
        onClick?(isSelected)
    }
    
}
