//
//  DateCell.swift
//  HabitTracker
//
//  Created by Daulet on 5/9/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit
import JTAppleCalendar
import PinLayout

class DateCell: JTACDayCell {
    
    enum State {
        case selected(position: SelectionRangePosition, isDone: Bool)
        case today(position: SelectionRangePosition)
        case notDone
        case `default`(isCurrentMonth: Bool)
    }
    
    private let colorRed = Color(hexString: "#FF3367")
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
    @IBOutlet private var todayIndicatorView: UIView!
    @IBOutlet private var doneImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clipsToBounds = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        todayIndicatorView.cornerRadius = todayIndicatorView.frame.height / 2
    }
    
    func set(state: State) {
        self.state = state
    }
    
    func set(text: String) {
        dateLabel.text = text
    }
    
    private func set(range position: SelectionRangePosition) {
        selectedView.backgroundColor = colorRed
        switch position {
        case .left:
            selectedView.layer.cornerRadius = radius
            selectedView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        case .middle:
            selectedView.layer.cornerRadius = .zero
            selectedView.layer.maskedCorners = []
        case .right:
            selectedView.layer.cornerRadius = radius
            selectedView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        case .full:
            selectedView.layer.cornerRadius = radius
            selectedView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        case .none:
            selectedView.backgroundColor = ColorName.uiWhite.color
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
            selectedView.backgroundColor = colorRed.withAlphaComponent(0.15)
        case let .selected(position, isDone):
            set(range: position)

            dateLabel.textColor = ColorName.uiWhite.color
            dateLabel.isHidden = isDone
            doneImageView.isHidden = !isDone
            todayIndicatorView.isHidden = true
            selectedView.backgroundColor = colorRed
        case let .today(position):
            set(range: position)
            
            dateLabel.textColor = ColorName.icons.color
            dateLabel.isHidden = false
            doneImageView.isHidden = true
            todayIndicatorView.isHidden = false
        case let .default(isCurrentMonth):
            dateLabel.textColor = isCurrentMonth ? ColorName.icons.color : ColorName.textSecondary.color
            dateLabel.isHidden = false
            selectedView.backgroundColor = ColorName.uiWhite.color
            doneImageView.isHidden = true
            todayIndicatorView.isHidden = true
        }
        layoutIfNeeded()
    }
    
}
