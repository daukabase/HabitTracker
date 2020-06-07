//
//  DateHeader.swift
//  HabitTracker
//
//  Created by Daulet on 6/6/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit
import JTAppleCalendar

final class DateHeader: JTACMonthReusableView {
    
    @IBOutlet var monthTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        monthTitle.font = FontFamily.Gilroy.semibold.font(size: 16)
    }
    
}
