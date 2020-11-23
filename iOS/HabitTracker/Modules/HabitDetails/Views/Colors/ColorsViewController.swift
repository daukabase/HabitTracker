//
//  BackgroundImagesViewController.swift
//  HabitTracker
//
//  Created by Daulet on 5/1/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

final class ColorsViewController: UIViewController {
    
    let spacing: CGFloat = 16
    var onColor: Closure<UIColor>?
    
    private(set) lazy var selectedColor: UIColor = colors[0]
    
    private var colors: [UIColor] = [
        ColorName.uiRed.color,
        ColorName.uiSkyBlue.color,
        ColorName.uiViolet.color,
        ColorName.uiGreen.color,
        ColorName.uiYellow.color,
        ColorName.uiHabitBlue.color
    ]
    
    private lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.font = FontFamily.Gilroy.regular.font(size: 16)
        label.textColor = ColorName.uiOrange.color
        label.text = "Color"
        
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(frame: .zero)
        
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = spacing
        
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(label)
        view.addSubview(stackView)
        
        label.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview()
        }
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(label.snp.bottom).offset(16)
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(35)
        }
         
        colors.forEach { (color) in
            let button = ColorButton()
            
            let totalSpacingWidth = spacing * CGFloat(colors.count - 1)
            let totalbuttonsWidth = view.frame.width - totalSpacingWidth
            let buttonWidth = totalbuttonsWidth / CGFloat(colors.count)
            button.size = buttonWidth
            
            button.configure(color: color)
            button.onClick = { [weak self, weak button] isSelected in
                guard let _button = button else {
                    return
                }
                self?.selectedColor = _button.color
                self?.onColor?(_button.color)
                
                self?.stackView.arrangedSubviews.forEach({ (view) in
                    guard let button = view as? ColorButton else {
                        return
                    }
                    button.isSelected = _button == button ? true : false
                })
                
                self?.stackView.layoutIfNeeded()
            }
            if (color == selectedColor) {
                button.isSelected = true
            }
            stackView.addArrangedSubview(button)
        }
    }
    
}
