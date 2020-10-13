//
//  HabitDetailsViewController.swift
//  HabitTracker
//
//  Created by Daulet on 4/25/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

final class HabitDetailsViewController: UIViewController, LoaderViewDisplayable {
    
    @IBOutlet var stackView: UIStackView!
    
    lazy var titleInputView: BaseInputView = {
        let titleInputView = BaseInputView(frame: .zero)
        titleInputView.setup(title: "Title", placeholder: "Enter title")
        
        return titleInputView
    }()
    
    lazy var notesInputView: BaseInputView = {
        let notesInputView = BaseInputView(frame: .zero)
        notesInputView.setup(title: "Notes", placeholder: "Description")
        
        return notesInputView
    }()
    
    lazy var durationView: DurationView = {
        let durationView = DurationView(frame: .zero)
        durationView.setup(title: "Duration")
        return durationView
    }()
    
    lazy var scheduleView: ScheduleView = {
        let scheduleView = ScheduleView(frame: .zero)
        scheduleView.titleLabel.text = "Schedule"
        scheduleView.onChange = { [weak self] in
            self?.changedSchedule()
        }
        return scheduleView
    }()
    
    lazy var chooseAllView: SwitchableView = {
        let chooseAllView = SwitchableView(frame: .zero)
        chooseAllView.label.text = "Choose everyday"
        chooseAllView.onStateChanged = { [weak scheduleView] isOn in
            if isOn {
                scheduleView?.selectAllDays()
            } else {
                scheduleView?.deselectAllDays()
            }
        }
        return chooseAllView
    }()
    
    lazy var remindView: SwitchableView = {
        let remindView = SwitchableView(frame: .zero)
        remindView.label.text = "Remind me"
        remindView.onStateChanged = { isOn in
            UIView.animate(withDuration: 0.3) {
                self.datePickerView.isHidden = !isOn
            }
        }
        return remindView
    }()
    
    lazy var iconsViewController = IconsViewController()
    lazy var colorsViewController = ColorsViewController()
    
    lazy var datePickerView: UIDatePicker = {
        let picker = UIDatePicker(frame: .zero)
        
        picker.datePickerMode = .time
        picker.isHidden = !remindView.isOn
        
        return picker
    }()
    
    lazy var saveButton: UIButton = {
        let saveButton = UIButton(frame: .zero)
        saveButton.apply(style: .blue)
        saveButton.title = "Save"
        saveButton.snp.makeConstraints { (make) in
            make.height.equalTo(50)
        }
        saveButton.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
        return saveButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        iconsViewController.setup(color: colorsViewController.selectedColor)
        colorsViewController.onColor = { [weak iconsViewController] color in
            iconsViewController?.setup(color: color)
        }
        
        commonInit()
        setupViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = ColorName.uiBlue.color
        navigationController?.navigationBar.roundCorners([.bottomLeft, .bottomRight], radius: 24)
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: FontFamily.Gilroy.medium.font(size: 24)!,
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func changedSchedule() {
        chooseAllView.set(isOn: scheduleView.isAllSelected)
    }
    
    private func commonInit() {
        title = "Habit details"
        
        setBackButton(style: .orange)
    }
    
    private func setupViews() {
        [iconsViewController, colorsViewController].forEach(addChild)
        
        [
            titleInputView,
            notesInputView,
            iconsViewController.view,
            colorsViewController.view,
            durationView,
            scheduleView,
            chooseAllView,
            remindView,
            datePickerView,
            saveButton
        ]
            .forEach(stackView.addArrangedSubview)
        
        stackView.setCustomSpacing(16, after: colorsViewController.view)
        stackView.setCustomSpacing(38, after: saveButton)
    }

    @objc
    private func didTapActionButton() {
        startLoading(isTransparentBackground: true)
        let days = Array(scheduleView.selectedDays)
        let frequency = Frequency.weekly(days)
        let habitId = UUID().uuidString
        let habit = HabitModel(id: habitId,
                               title: titleInputView.text,
                               notes: notesInputView.text,
                               frequence: frequency,
                               colorHex: colorsViewController.selectedColor.toHexString(),
                               icon: iconsViewController.selectedIcon.rawValue,
                               startDate: durationView.startDate.string(with: .storingFormat),
                               durationDays: durationView.durationDays)
        
        generateHabitBehavior(for: habit)
        
        HabitStorage.create(habit: habit) { (isCreated) in
            self.endLoading()
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    private func generateHabitBehavior(for habit: HabitModel) {
        let checkpoints = generateCheckpoints(for: habit)
        HabitStorage.set(checkpoints: checkpoints) { isSucceed in
            guard isSucceed else { return }
            
            checkpoints.forEach { checkpointModel in
                Notifications.shared.setupNotification(for: checkpointModel, of: habit)
            }
        }
    }
    
    private func generateCheckpoints(for habit: HabitModel) -> [CheckpointModel] {
        guard let startDate = habit.startDate.date(with: .storingFormat) else {
            assertionFailure("Something wrong")
            return []
        }
        let dates = generateDates(for: habit.frequence,
                                  startDate: startDate,
                                  durationDays: habit.durationDays)
        
        let checkpoints = dates.map { date -> CheckpointModel in
            return CheckpointModel(id: UUID().uuidString,
                                   habitId: habit.id,
                                   date: date.string(with: .storingFormat),
                                   isDone: false)
        }
        
        return checkpoints
    }
    
    private func generateDates(for frequency: Frequency, startDate: Date, durationDays: Int) -> [Date] {
        var dates = [Date]()
        switch frequency {
        case let .weekly(days):
            let days = Set(days)
            
            for dayCount in 0..<durationDays {
                guard let date = Calendar.current.date(byAdding: .day, value: dayCount, to: startDate) else {
                    assertionFailure("Something wrong")
                    continue
                }
                
                guard days.contains(date.day) else {
                    continue
                }
                
                dates.append(date)
            }
        case .daily:
            fatalError("Not available")
        }
        
        return dates
    }
    
}
