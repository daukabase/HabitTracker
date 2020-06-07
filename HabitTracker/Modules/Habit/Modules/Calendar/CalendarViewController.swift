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
    
    private var dateFormatter: DateFormatter = Formatter.MMMyyyy
    private var notDoneDates = Set(["2020-06-09T15:33:37.471+0000".date(with: .iso8601)!.daySerialized])
    private var doneDates = Set<Date>()
    
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
        
        calendarView.scrollDirection = .vertical
        calendarView.scrollingMode = .stopAtEachCalendarFrame
        calendarView.rangeSelectionMode = .continuous
        calendarView.allowsMultipleSelection = true
        calendarView.showsHorizontalScrollIndicator = false
        
        let startDate1 = "2020-05-26T15:33:37.471+0600".date(with: .iso8601)!.daySerialized
        let endDate1 = "2020-06-09T15:33:37.471+0600".date(with: .iso8601)!.daySerialized
        
        let startDate2 = "2020-06-11T15:33:37.471+0600".date(with: .iso8601)!.daySerialized
        let endDate2 = "2020-06-15T15:33:37.471+0600".date(with: .iso8601)!.daySerialized
        
        doneDates = Set(
            Date.dates(from: startDate1, to: endDate1).map { $0.daySerialized }
        )
        
        let intervals = [
            (startDate1, endDate1),
            (startDate2, endDate2)
        ]
        
        let dates = getDates(by: intervals)
        
        DispatchQueue.main.async {
            self.calendarView.reloadData()
            self.calendarView.selectDates(dates, triggerSelectionDelegate: true, keepSelectionIfMultiSelectionAllowed: true)
            self.calendarView.reloadData()
        }
    }
    
    private func getDates(by intervals: [(Date, Date)]) -> [Date] {
        let dates = intervals.reduce([]) { (result, args) -> [Date] in
            let (date1, date2) = args
            
            if date1 < date2 {
                return result + Date.dates(from: date1.daySerialized, to: date2.daySerialized)
            }
            
            return result
        }
        
        return dates
    }
    
    private func setDateInterval(between date1: Date, _ date2: Date) {
        let dates = Date.dates(from: date1, to: date2)
        
        calendarView.reloadData()
        calendarView.selectDates(dates, triggerSelectionDelegate: true, keepSelectionIfMultiSelectionAllowed: true)
        calendarView.reloadData()
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
        let startDate = "2020-05-06T15:33:37.471+0600".date(with: .iso8601)!
        let endDate = Date()
        
        let parameters = ConfigurationParameters(startDate: startDate,
                                                 endDate: endDate,
                                                 generateInDates: .off,
                                                 generateOutDates: .off)
        
        return parameters
    }
    
}

private extension CalendarViewController {
    
    func configure(cell: JTACDayCell?, cellState: CellState) {
        guard let cell = cell as? DateCell else {
            return
        }
        
        let state: DateCell.State
        
        let isToday = Calendar.current.isDateInToday(cellState.date)
        let isNotDoneDay = notDoneDates.contains(cellState.date.daySerialized)
        let isDone = doneDates.contains(cellState.date.daySerialized)
        
        if isToday {
            state = .today(position: cellState.selectedPosition())
        } else if cellState.isSelected {
            state = .selected(position: cellState.selectedPosition(), isDone: isDone)
        } else if isNotDoneDay {
            state = .notDone
        } else {
            state = .default(isCurrentMonth: cellState.dateBelongsTo == .thisMonth)
        }
        
        cell.set(state: state)
        cell.set(text: cellState.text)
        cell.layoutIfNeeded()
    }
    
}
