//
//  DayButton.swift
//  HabitTracker
//
//  Created by Daulet on 4/26/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit
import PinLayout

class DayButton: UIButton {
    
    var onClick: BoolClosure?
    var day: Day = .monday {
        didSet {
            setTitle(day.title, for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        pin.width(frame.height)
        layer.cornerRadius = frame.height / 2
        
        titleLabel?.pin.sizeToFit().center()
    }
    
    func commonInit() {
        setTitleColor(ColorName.uiWhite.color, for: .selected)
        setTitleColor(ColorName.uiBlue.color, for: .normal)
        setBackgroundColor(ColorName.uiBlue.color, for: .selected)
        setBackgroundColor(ColorName.uiWhite.color, for: .normal)
        clipsToBounds = true
        
        layer.borderColor = ColorName.uiBlue.color.cgColor
        layer.borderWidth = 1
        
        titleLabel?.font = FontFamily.Gilroy.regular.font(size: 18)
        addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }
    
    @objc func didTap() {
        isSelected.toggle()
        layoutIfNeeded()
        onClick?(isSelected)
    }
    
}
