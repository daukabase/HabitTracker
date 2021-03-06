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
    
    // MARK: - Properties
    private var dateFormatter: DateFormatter = Formatter.MMMyyyy
    private var notDoneDates = Set<Date>()
    private var doneDates = Set<Date>()
    private var themeColor = UIColor.clear
    private var bufferColorSetup: Closure<UIColor>?
    
    // MARK: - Views
    @IBOutlet var containerView: UIView!
    @IBOutlet var doneDescriptionView: UIView!
    @IBOutlet var notDoneDescriptionView: UIView!
    @IBOutlet var calendarView: JTACMonthView!
    @IBOutlet var roundViews: [UIView]!
    @IBOutlet var backgroundedView: [UIView]!
    
    // MARK: - Superview
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundedView.forEach {
            $0.backgroundColor = .clear
        }
        containerView.layer.backgroundColor = UIColor.clear.cgColor
        containerView.applyDropShadow()
        
        calendarView.scrollDirection = .horizontal
        calendarView.scrollingMode = .stopAtEachCalendarFrame
        calendarView.rangeSelectionMode = .continuous
        calendarView.allowsMultipleSelection = true
        calendarView.showsHorizontalScrollIndicator = false
        
        roundViews.forEach { $0.round() }
        applyMocks()
        bufferColorSetup?(themeColor)
    }
    
    // MARK: - Internal Methods
    func setup(theme color: UIColor) {
        self.themeColor = color
        
        guard isViewLoaded else {
            bufferColorSetup = setup(theme:)
            return
        }
        
        self.doneDescriptionView.backgroundColor = color
        self.notDoneDescriptionView.backgroundColor = color.withAlphaComponent(0.15)
        
        DispatchQueue.main.async {
            self.calendarView.reloadData()
        }
    }
    
    // MARK: - Private Methods
    private func applyMocks() {
        let startDate1 = "2020-05-26T15:33:37.471+0600".date(with: .iso8601)!.daySerialized
        let endDate1 = "2020-06-02T15:33:37.471+0600".date(with: .iso8601)!.daySerialized
        
        let startDate2 = "2020-06-06T15:33:37.471+0600".date(with: .iso8601)!.daySerialized
        let endDate2 = "2020-06-15T15:33:37.471+0600".date(with: .iso8601)!.daySerialized
        
        let notDone1 = "2020-06-02T15:33:37.471+0000".date(with: .iso8601)!.daySerialized
        let notDone2 = "2020-06-04T15:33:37.471+0000".date(with: .iso8601)!.daySerialized
        
        doneDates = Set(
            Date.dates(from: startDate1, to: startDate2).map { $0.daySerialized }
        )
        notDoneDates = Set(
            Date.dates(from: notDone1, to: notDone2)
        )
        
        let intervals = [
            (startDate1, endDate1),
            (startDate2, endDate2)
        ]
        
        setupCalendar(with: intervals)
    }
    
    private func setupCalendar(with intervals: [(Date, Date)]) {
        let dates = getDates(by: intervals)
        
        DispatchQueue.main.async {
            self.calendarView.reloadData()
            self.calendarView.selectDates(dates, triggerSelectionDelegate: true, keepSelectionIfMultiSelectionAllowed: true)
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
    
}

extension CalendarViewController: JTACMonthViewDelegate {
    
    // MARK: - JTACMonthViewDelegate
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
        return MonthSize(defaultSize: 100)
    }
    
}

extension CalendarViewController: JTACMonthViewDataSource {
    
    // MARK: - JTACMonthViewDataSource
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        let startDate = "2020-05-06T15:33:37.471+0600".date(with: .iso8601)!
        let endDate = Date()
        
        let parameters = ConfigurationParameters(startDate: startDate,
                                                 endDate: endDate,
                                                 generateInDates: .forAllMonths,
                                                 generateOutDates: .off)
        
        return parameters
    }
    
}

private extension CalendarViewController {
    
    // MARK: - Private Configurations
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
        
        cell.set(state: state, with: themeColor)
        cell.set(text: cellState.text)
        cell.layoutIfNeeded()
    }
    
}
