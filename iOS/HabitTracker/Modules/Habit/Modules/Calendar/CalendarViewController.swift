//
//  CalendarViewController.swift
//  HabitTracker
//
//  Created by Daulet on 5/9/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit
import JTAppleCalendar

final class CalendarViewController: UIViewController, LoaderViewDisplayable {
    
    // MARK: - Properties
    private var bufferColorSetup: Closure<UIColor>?
    private var viewModel: CalendarViewModel = CalendarViewModel(checkpoints: [], color: .clear)
    
    // MARK: - Views
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var doneDescriptionView: UIView!
    @IBOutlet private var notDoneDescriptionView: UIView!
    @IBOutlet private var calendarView: JTACMonthView!
    @IBOutlet private var roundViews: [UIView]!
    @IBOutlet private var backgroundedView: [UIView]!
    
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
        bufferColorSetup?(viewModel.themeColor)
        startLoading()
    }
    
    // MARK: - Internal Methods
    func setup(model: CalendarViewModel) {
        startLoading()
        self.viewModel = model
        setup(theme: model.themeColor)
        setup(dates: model.selectedDates)
    }
    
    // MARK: - Private Setup
    private func setup(theme color: UIColor) {
        doneDescriptionView.backgroundColor = color
        notDoneDescriptionView.backgroundColor = color.withAlphaComponent(0.15)
    }
    
    private func setup(dates: [Date]) {
        calendarView.selectDates(dates, triggerSelectionDelegate: true, keepSelectionIfMultiSelectionAllowed: true)
        calendarView.reloadData()
        endLoading()
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
        
        header.monthTitle.text = viewModel.dateFormatter.string(from: range.start)
        
        return header
    }
    
    func calendarSizeForMonths(_ calendar: JTACMonthView?) -> MonthSize? {
        return MonthSize(defaultSize: 100)
    }
    
}

extension CalendarViewController: JTACMonthViewDataSource {
    
    // MARK: - JTACMonthViewDataSource
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        let startDate = viewModel.startDate
        let endDate = viewModel.endDate
        
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
        let missedDay = viewModel.isMissed(date: cellState.date)
        let isDone = viewModel.isDone(for: cellState.date)
        
        if isToday && !isDone {
            state = .today(position: cellState.selectedPosition())
        } else if cellState.isSelected {
            // every selectedCellStates from past is done
            state = .selected(position: cellState.selectedPosition(), isDone: isDone)
        } else if missedDay {
            state = .notDone
        } else {
            state = .default(isCurrentMonth: cellState.dateBelongsTo == .thisMonth)
        }
        
        cell.set(state: state, with: viewModel.themeColor)
        cell.set(text: cellState.text)
        cell.layoutIfNeeded()
    }
    
}
