//
//  CalendarViewController.swift
//  HabitTracker
//
//  Created by Daulet on 5/9/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit
import JTAppleCalendar

struct CalendarViewModel {
    
    private var dateCheckpointMap: [Date: CheckpointModel] = [:]
    
    let startDate: Date
    let endDate: Date
    let dates: [Date]
    let themeColor: UIColor
    let dateFormatter = Formatter.MMMyyyy
    
    func isDone(for date: Date) -> Bool {
        print("[DEBUG] GET " + String(describing: date) + " " + (dateCheckpointMap[date.daySerialized]?.id ?? "NOPE"))
        return dateCheckpointMap[date]?.isDone ?? false
    }
    
    func isMissed(date: Date) -> Bool {
        guard let checkpoint = dateCheckpointMap[date] else {
            return false
        }
        return !checkpoint.isDone
    }
    
    init(checkpoints: [CheckpointModel], color: UIColor) {
        let dates = checkpoints
            .filter { checkpoint in
                guard let date = checkpoint.date else {
                    return checkpoint.isDone
                }
                return checkpoint.isDone || date > Date()
            }
            .compactMap {
                $0.date
            }
        
        self.dates = dates
        self.startDate = dates.min() ?? Date()
        self.endDate = dates.max() ?? Date()
        self.themeColor = color
        
        checkpoints.forEach { checkpoint in
            guard let date = checkpoint.date else {
                return
            }
            print("[DEBUG] Set " + String(describing: date) + checkpoint.id)
            dateCheckpointMap[date] = checkpoint
        }
        
    }
    
}

final class CalendarViewController: UIViewController {
    
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
    }
    
    // MARK: - Internal Methods
    func setup(model: CalendarViewModel) {
        self.viewModel = model
        setup(theme: model.themeColor)
        setup(dates: model.dates)
        
        DispatchQueue.main.async {
            self.calendarView.reloadData()
        }
    }
    
    // MARK: - Private Setup
    private func setup(theme color: UIColor) {
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
    
    private func setup(dates: [Date]) {
        DispatchQueue.main.async {
            self.calendarView.reloadData()
            self.calendarView.selectDates(dates, triggerSelectionDelegate: true, keepSelectionIfMultiSelectionAllowed: true)
        }
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
        let isDone = viewModel.isDone(for: cellState.date)
        let missedDay = viewModel.isMissed(date: cellState.date)
        
        if isToday {
            state = .today(position: cellState.selectedPosition())
        } else if cellState.isSelected {
            print("[DEBUG] \(cellState.date) ++++ \(isDone)")
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
