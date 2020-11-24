//
//  ScheduleView.swift
//  HabitTracker
//
//  Created by Daulet on 4/26/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit
import SnapKit

final class ScheduleView: UIView {
    
    // MARK: - Properties
    var onChange: EmptyClosure?
    
    var isAllSelected: Bool {
        return selectedDays.count == Day.allCases.count
    }
    
    var selectedDays: Set<Day> {
        get {
            getSelectedDays()
        }
        set {
            set(selected: newValue)
        }
    }
    
    var title: String {
        get {
            return titleLabel.text ?? ""
        }
        set {
            titleLabel.text = newValue
        }
    }
    
    // MARK: - Views
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.font = FontFamily.Gilroy.regular.font(size: 16)
        label.textColor = ColorName.uiOrange.color
        
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(frame: .zero)
        
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 12
        
        return stack
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Internal Methods
    func selectAllDays() {
        stackView.arrangedSubviews.forEach {
            guard let dayButton = $0 as? DayButton else {
                return
            }
            
            dayButton.isSelected = true
        }
        layoutIfNeeded()
    }
    
    func deselectAllDays() {
        stackView.arrangedSubviews.forEach {
            guard let dayButton = $0 as? DayButton else {
                return
            }
            
            dayButton.isSelected = false
        }
        layoutIfNeeded()
    }
    
    // MARK: - Private Methods
    private func commonInit() {
        addSubview(titleLabel)
        addSubview(stackView)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.right.equalToSuperview()
            make.height.equalTo(34)
            make.bottom.equalToSuperview().offset(-4)
        }
        
        Day.allCases.forEach { (day) in
            let dayButton = DayButton(frame: .zero)
            dayButton.day = day
            
            dayButton.onClick = { [weak self] _ in
                self?.onChange?()
            }
            
            stackView.addArrangedSubview(dayButton)
        }
    }
    
    private func set(selected days: Set<Day>) {
        deselectAllDays()
        
        stackView.arrangedSubviews.forEach {
            guard let dayButton = $0 as? DayButton, days.contains(dayButton.day) else {
                return
            }
            
            dayButton.isSelected = true
        }
        setNeedsLayout()
    }
    
    private func getSelectedDays() -> Set<Day> {
        var selectedDays = Set<Day>()
        stackView.arrangedSubviews.forEach {
            guard let dayButton = $0 as? DayButton, dayButton.isSelected else {
                return
            }
            
            selectedDays.insert(dayButton.day)
        }
        return selectedDays
    }
    
}
