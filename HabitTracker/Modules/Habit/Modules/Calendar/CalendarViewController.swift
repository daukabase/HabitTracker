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
    
    private lazy var dateFormatter: DateFormatter = Formatter.MMMyyyy
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var calendarView: JTACMonthView!
    @IBOutlet var backgroundedView: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundedView.forEach {
            $0.backgroundColor = .clear
        }
        containerView.layer.backgroundColor = UIColor.clear.cgColor
        containerView.applyDropShadow()
        
        calendarView.scrollDirection = .horizontal
        calendarView.scrollingMode = .stopAtEachCalendarFrame
        calendarView.allowsMultipleSelection = true
        calendarView.rangeSelectionMode = .continuous
        calendarView.showsHorizontalScrollIndicator = false
        calendarView.showsVerticalScrollIndicator = false
        
        setDateInterval()
    }
    
    private func setDateInterval() {
        let startDate = "2020-05-21T15:33:37.471+0600".date(with: .iso8601)!
        let endDate = "2020-06-02T15:33:37.471+0600".date(with: .iso8601)!
        
        let dates = Date.dates(from: startDate, to: endDate)
        
        calendarView.selectDates(dates)
    }
    
}

extension Date {
    static func dates(from fromDate: Date, to toDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = fromDate

        while date <= toDate {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }
        return dates
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
    
    func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        configure(cell: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTACMonthView, didDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        configure(cell: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTACMonthView, shouldSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) -> Bool {
        return true
    }
    
    func calendar(_ calendar: JTACMonthView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTACMonthReusableView {
        let header = calendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: "DateHeader", for: indexPath) as! DateHeader
        
        header.monthTitle.text = dateFormatter.string(from: range.start)
        
        return header
    }
    
    func calendarSizeForMonths(_ calendar: JTACMonthView?) -> MonthSize? {
        return MonthSize(defaultSize: 64)
    }
    
}

extension CalendarViewController: JTACMonthViewDataSource {
    
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        let startDate = "2020-04-06T15:33:37.471+0600".date(with: .iso8601)!
        let endDate = Date()
        
        let parameters = ConfigurationParameters(startDate: startDate,
                                                 endDate: endDate,
                                                 generateInDates: .forAllMonths,
                                                 generateOutDates: .tillEndOfGrid)
        
        return parameters
    }
    
}

private extension CalendarViewController {
    
    func configure(cell: JTACDayCell?, cellState: CellState) {
        guard let cell = cell as? DateCell else {
            return
        }
        
        cell.dateLabel.text = cellState.text
        handleCellTextColor(cell: cell, cellState: cellState)
        handleCellSelected(cell: cell, cellState: cellState)
    }
    
    func handleCellTextColor(cell: DateCell, cellState: CellState) {
        if cellState.dateBelongsTo == .thisMonth {
            cell.dateLabel.textColor = ColorName.textPrimary.color
        } else {
            cell.dateLabel.textColor = ColorName.textSecondary.color
        }
    }
    
    func handleCellSelected(cell: DateCell, cellState: CellState) {
        cell.set(range: cellState.selectedPosition())
    }
    
}
