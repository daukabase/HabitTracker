//
//  CalendarViewController.swift
//  HabitTracker
//
//  Created by Daulet on 5/9/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit
import JTAppleCalendar

final class CalendarViewController: UIViewController {
    
    @IBOutlet var containerView: UIView!
    
    @IBOutlet var backgroundedView: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundedView.forEach {
            $0.backgroundColor = .clear
        }
        containerView.layer.backgroundColor = UIColor.clear.cgColor
        containerView.applyDropShadow()
    }
    
}

extension CalendarViewController: JTACMonthViewDelegate {
    
    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: DateCell.identifier, for: indexPath) as! DateCell
        
        self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        
        return cell
    }
    
    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        configure(cell: cell, cellState: cellState)
    }
    
}

extension CalendarViewController: JTACMonthViewDataSource {
    
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        let startDate = "01.01.2020".date(with: .ddMMYYYY)!
        let endDate = "25.08.2020".date(with: .ddMMYYYY)!
        return ConfigurationParameters(startDate: startDate,
                                       endDate: endDate,
                                       generateInDates: .forAllMonths,
                                       generateOutDates: .tillEndOfGrid)
    }
    
}

extension CalendarViewController {
    
    func configure(cell: JTACDayCell?, cellState: CellState) {
        guard let cell = cell as? DateCell else {
            return
        }
        
        cell.dateLabel.text = cellState.text
        handleCellTextColor(cell: cell, cellState: cellState)
    }
    
    func handleCellTextColor(cell: DateCell, cellState: CellState) {
        if cellState.dateBelongsTo == .thisMonth {
            cell.dateLabel.textColor = ColorName.textPrimary.color
        } else {
            cell.dateLabel.textColor = ColorName.textSecondary.color
        }
    }
    
}
