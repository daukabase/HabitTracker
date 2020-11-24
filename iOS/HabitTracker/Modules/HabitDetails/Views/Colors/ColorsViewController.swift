//
//  BackgroundImagesViewController.swift
//  HabitTracker
//
//  Created by Daulet on 5/1/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

final class ColorsViewController: UIViewController {
    
    // MARK: - Properties
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
    
    // MARK: - Views
    private lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.font = FontFamily.Gilroy.regular.font(size: 16)
        label.textColor = ColorName.uiOrange.color
        label.text = "Color"
        
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(frame: .zero)
        
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = spacing
        
        return stack
    }()
    
    // MARK: - UIViewController
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
         
        colors.forEach { color in
            let button = generateButton(for: color)
            
            stackView.addArrangedSubview(button)
        }
    }
    
    // MARK: - Internal Methods
    func set(selected color: UIColor) {
        guard colors.contains(color) else {
            return
        }
        
        stackView.arrangedSubviews.forEach { view in
            guard let button = view as? ColorButton else {
                return
            }
            button.isSelected = button.color == color
        }
    }
    
    // MARK: - Private Methods
    private func generateButton(for color: UIColor) -> ColorButton {
        let button = ColorButton()
        
        let totalSpacingWidth = spacing * CGFloat(colors.count - 1)
        let totalbuttonsWidth = view.frame.width - totalSpacingWidth
        let buttonWidth = totalbuttonsWidth / CGFloat(colors.count)
        button.size = buttonWidth
        
        button.configure(color: color)
        button.onClick = { [weak self, weak button] _ in
            self?.select(for: button)
        }
        if (color == selectedColor) {
            button.isSelected = true
        }
        
        return button
    }
    
    private func select(for button: ColorButton?) {
        guard let _button = button else {
            return
        }
        selectedColor = _button.color
        onColor?(_button.color)
        
        stackView.arrangedSubviews.forEach({ (view) in
            guard let button = view as? ColorButton else {
                return
            }
            button.isSelected = _button == button ? true : false
        })
        
        stackView.layoutIfNeeded()
    }
    
}
