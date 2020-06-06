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
    
    private var radius: CGFloat {
        return frame.height / 2
    }
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var selectedView: UIView!
    @IBOutlet var doneImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectedView.isHidden = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    func set(range position: SelectionRangePosition) {
        switch position {
        case .left:
            selectedView.roundCorners([.bottomLeft, .topRight], radius: radius)
            selectedView.isHidden = false
        case .middle:
            selectedView.roundCorners([], radius: .zero)
            selectedView.isHidden = false
        case .right:
            selectedView.roundCorners([.bottomRight, .topLeft], radius: radius)
            selectedView.isHidden = false
        case .full:
            selectedView.roundCorners(.allCorners, radius: radius)
            selectedView.isHidden = false
        case .none:
            selectedView.isHidden = true
        }
    }
    
}
