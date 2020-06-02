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
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var doneImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        doneImageView.isHidden = true
    }
    
}
