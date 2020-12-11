//
//  BackgroundImagesViewController.swift
//  HabitTracker
//
//  Created by Daulet on 5/1/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

final class ColorsViewController: UIViewController {
    
    private enum Constants {
        static let habitColors: [HabitColor] = HabitColor.allCases
        static let initialSelectedColor = HabitColor.default
        static let spacing: CGFloat = 16
    }
    
    // MARK: - Properties
    var onColor: Closure<UIColor>?
    
    var selectedColor: HabitColor {
        for view in stackView.arrangedSubviews {
            guard let button = view as? ColorButton, button.isSelected else {
                continue
            }
            return button.habitColor
        }
        
        return Constants.initialSelectedColor
    }
    
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
        stack.spacing = Constants.spacing
        
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
         
        Constants.habitColors.forEach { color in
            let button = generateButton(for: color)
            
            stackView.addArrangedSubview(button)
        }
        
        set(selected: Constants.initialSelectedColor)
    }
    
    // MARK: - Internal Methods
    func set(selected color: UIColor) {
        guard let habitColor = Constants.habitColors.first(where: { $0.color == color }) else {
            return
        }
        set(selected: habitColor)
    }
    
    // MARK: - Private Methods
    private func generateButton(for habitColor: HabitColor) -> ColorButton {
        let totalSpacingWidth = Constants.spacing * CGFloat(Constants.habitColors.count - 1)
        let totalbuttonsWidth = view.frame.width - totalSpacingWidth
        let buttonWidth = totalbuttonsWidth / CGFloat(Constants.habitColors.count)
        
        let button = ColorButton()
        
        button.size = buttonWidth
        button.configure(habitColor: habitColor)
        
        button.onClick = { [weak self] habitColor in
            self?.set(selected: habitColor)
        }
        
        return button
    }
    
    private func set(selected habitColor: HabitColor) {
        onColor?(habitColor.color)
        
        stackView.arrangedSubviews.forEach { view in
            guard let button = view as? ColorButton else {
                return
            }
            button.isSelected = button.habitColor == habitColor
        }
    }
        
}
