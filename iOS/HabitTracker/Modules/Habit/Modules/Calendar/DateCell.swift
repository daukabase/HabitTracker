//
//  DateCell.swift
//  HabitTracker
//
//  Created by Daulet on 5/9/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit
import JTAppleCalendar

class DateCell: JTACDayCell {
    
    enum State {
        case selected(position: SelectionRangePosition, isDone: Bool)
        case today(position: SelectionRangePosition)
        case notDone
        case `default`(isCurrentMonth: Bool)
    }
    
    private var color = UIColor(hexString: "#FF3367")
    private var radius: CGFloat {
        return selectedView.frame.height / 2
    }
    
    private var state: State = .default(isCurrentMonth: true) {
        didSet {
            updateState()
        }
    }
    
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var selectedView: UIView!
    @IBOutlet private var selectedSingleView: UIView!
    @IBOutlet private var todayIndicatorView: UIView!
    @IBOutlet private var doneImageView: UIImageView!
    
    @IBOutlet private var selectedViewLeftConstraint: NSLayoutConstraint!
    @IBOutlet private var selectedViewRightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clipsToBounds = false
        isUserInteractionEnabled = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        todayIndicatorView.cornerRadius = todayIndicatorView.frame.height / 2
        selectedSingleView.layer.cornerRadius = selectedSingleView.frame.height / 2
    }
    
    func set(state: State, with color: UIColor) {
        self.color = color
        self.state = state
    }
    
    func set(text: String) {
        dateLabel.text = text
    }
    
    private func set(selected color: UIColor) {
        [selectedView, selectedSingleView].forEach { $0.backgroundColor = color }
    }
    
    private func set(range position: SelectionRangePosition) {
        set(selected: color)
        
        selectedView.isHidden = position == .full
        selectedSingleView.isHidden = position != .full
        
        selectedViewLeftConstraint.constant = -0.5
        selectedViewRightConstraint.constant = -0.5
        
        switch position {
        case .left:
            selectedViewLeftConstraint.constant = 0
            selectedViewRightConstraint.constant = -0.5
            
            selectedView.layer.cornerRadius = radius
            selectedView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        case .middle:
            selectedView.layer.cornerRadius = .zero
            selectedView.layer.maskedCorners = []
        case .right:
            selectedViewLeftConstraint.constant = -0.5
            selectedViewRightConstraint.constant = 0
            
            selectedView.layer.cornerRadius = radius
            selectedView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        case .full:
            break
        case .none:
            selectedView.backgroundColor = ColorName.uiWhite.color
            selectedSingleView.backgroundColor = ColorName.uiWhite.color
        }
    }
    
    private func updateState() {
        switch state {
        case .notDone:
            set(range: .full)
            
            dateLabel.textColor = ColorName.uiWhite.color
            dateLabel.isHidden = false
            doneImageView.isHidden = true
            todayIndicatorView.isHidden = true
            set(selected: color.withAlphaComponent(0.15))
        case let .selected(position, isDone):
            set(range: position)

            dateLabel.textColor = ColorName.uiWhite.color
            dateLabel.isHidden = isDone
            doneImageView.isHidden = !isDone
            todayIndicatorView.isHidden = true
            set(selected: color)
        case let .today(position):
            set(range: position)
            
            dateLabel.textColor = ColorName.icons.color
            dateLabel.isHidden = false
            doneImageView.isHidden = true
            todayIndicatorView.isHidden = false
        case let .default(isCurrentMonth):
            set(selected: ColorName.uiWhite.color)
            
            dateLabel.textColor = isCurrentMonth ? ColorName.icons.color : ColorName.textSecondary.color
            dateLabel.isHidden = false
            doneImageView.isHidden = true
            todayIndicatorView.isHidden = true
        }
        layoutIfNeeded()
    }
    
}
