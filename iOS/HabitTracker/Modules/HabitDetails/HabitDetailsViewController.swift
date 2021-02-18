//
//  HabitDetailsViewController.swift
//  HabitTracker
//
//  Created by Daulet on 4/25/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit
import Promises
import Haptica

protocol HabitDetailsDelegate: class {
    func didEndEditHabit()
}

final class HabitDetailsViewController: UIViewController, LoaderViewDisplayable, InfoDisplayable {
    
    // MARK: - Nested Types
    enum Context {
        case createNew
        case edit(Habit)
    }
    
    // MARK: - Properties
    weak var delegate: HabitDetailsDelegate?
    
    private static let queue = DispatchQueue.global(qos: .userInteractive)
    
    private var interactor: HabitDetailsInteractorInput = HabitDetailsInteractor()
    private let context: Context
    
    // MARK: - Views
    @IBOutlet private var stackView: UIStackView!
    
    private lazy var titleInputView: BaseInputView = {
        let titleInputView = BaseInputView(frame: .zero)
        titleInputView.setup(title: L10n.HabitDetails.Title.title,
                             placeholder: L10n.HabitDetails.Title.placeholder)
        
        return titleInputView
    }()
    
    private lazy var notesInputView: BaseInputView = {
        let notesInputView = BaseInputView(frame: .zero)
        notesInputView.setup(title: L10n.HabitDetails.Notes.title,
                             placeholder: L10n.HabitDetails.Notes.placeholder)
        
        return notesInputView
    }()
    
    private lazy var durationView: DurationView = {
        let durationView = DurationView(frame: .zero)
        durationView.setup(title: L10n.HabitDetails.Duration.title)
        return durationView
    }()
    
    private lazy var scheduleView: ScheduleView = {
        let scheduleView = ScheduleView(frame: .zero)
        scheduleView.title = L10n.HabitDetails.Schedule.title
        scheduleView.onChange = { [weak self] in
            self?.changedSchedule()
        }
        return scheduleView
    }()
    
    private lazy var chooseAllView: SwitchableView = {
        let chooseAllView = SwitchableView(frame: .zero)
        chooseAllView.label.text = L10n.HabitDetails.Schedule.chooseAll
        chooseAllView.onStateChanged = { [weak scheduleView] isOn in
            if isOn {
                scheduleView?.selectAllDays()
            } else {
                scheduleView?.deselectAllDays()
            }
        }
        return chooseAllView
    }()
    
    private lazy var remindView: SwitchableView = {
        let remindView = SwitchableView(frame: .zero)
        remindView.label.text = L10n.HabitDetails.Reminder.remindMe
        remindView.onStateChanged = { [weak remindView, weak self] isOn in
            self?.handleRemindViewStateUpdate()
        }
        return remindView
    }()
    
    private lazy var datePickerView: UIDatePicker = {
        let picker = UIDatePicker(frame: .zero)
        
        picker.datePickerMode = .time
        picker.isHidden = !remindView.isOn
        picker.timeZone = .current
        
        if #available(iOS 13.4, *) {
            picker.preferredDatePickerStyle = .wheels
        }
        
        return picker
    }()
    
    private lazy var saveButton: UIButton = {
        let saveButton = UIButton(frame: .zero)
        saveButton.apply(style: .blue)
        saveButton.snp.makeConstraints { (make) in
            make.height.equalTo(50)
        }
        saveButton.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
        return saveButton
    }()
    
    // MARK: - Controllers
    private lazy var iconsViewController = IconsViewController()
    
    private lazy var colorsViewController = ColorsViewController()
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonInit()
        setupViews()
        setupContext()
        
        iconsViewController.setup(color: colorsViewController.selectedColor.color)
        colorsViewController.onColor = { [weak iconsViewController] color in
            iconsViewController?.setup(color: color)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Init
    init(context: Context, delegate: HabitDetailsDelegate?) {
        self.context = context
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Logic
    func changedSchedule() {
        chooseAllView.set(isOn: scheduleView.isAllSelected)
    }
    
    // MARK: - Private Setup
    private func commonInit() {
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

    // MARK: - Actions
    @objc
    private func didTapActionButton() {
        guard isAllDataFilled() else {
            return
        }
        
        startLoading(isTransparentBackground: true)
        switch context {
        case .createNew:
            createHabit()
        case let .edit(habit):
            editHabit(with: habit.id)
        }
        Haptic.impact(.heavy).generate()
    }
    
    // MARK: - Private Methods
    private func createHabit() {
        let habit = getHabit()
        let remindTime = remindView.isOn ? datePickerView.date : nil
        interactor.create(habit: habit, remindTime: remindTime) { [weak self] result in
            self?.endLoading()
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: .updateHabits, object: nil)
                self?.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    private func editHabit(with id: String) {
        let habit = getHabit(with: id)
        
        let remindTime = remindView.isOn ? datePickerView.date : nil
        interactor.edit(habit: habit, remindTime: remindTime) { [weak self] result in
            self?.endLoading()
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: .updateHabits, object: nil)
                self?.navigationController?.popToRootViewController(animated: true)
                self?.delegate?.didEndEditHabit()
            }
        }
    }
    
    private func isAllDataFilled() -> Bool {
        if titleInputView.text.isEmpty {
            showAlert(title: "", message: L10n.HabitDetails.Info.enterTitle)
            return false
        }
        
        if scheduleView.selectedDays.isEmpty {
            showAlert(title: "", message: L10n.HabitDetails.Info.scheduleTitle)
            return false
        }
        
        return true
    }
    
    private func getHabit(with id: String = UUID().uuidString) -> HabitModel {
        let days = Array(scheduleView.selectedDays)
        let frequency = Frequency.weekly(days)
        let habit = HabitModel(id: id,
                               title: titleInputView.text,
                               notes: notesInputView.text,
                               frequence: frequency,
                               colorHex: colorsViewController.selectedColor.color.toHexString(),
                               icon: iconsViewController.selectedIcon.rawValue,
                               startDate: durationView.startDate,
                               durationDays: durationView.durationDays)
        
        return habit
    }
    
    private func setupContext() {
        switch context {
        case .createNew:
            title = L10n.HabitDetails.Create.title
            saveButton.title = L10n.HabitDetails.Create.action
            fillDataIfTest()
        case let .edit(habit):
            title = L10n.HabitDetails.Edit.title
            saveButton.title = L10n.HabitDetails.Edit.action
            setup(habit: habit)
        }
    }
    
    private func fillDataIfTest() {
        guard Target.current == .fastlaneUiTest else {
            return
        }
        
        setup(habit: FastlaneData.TestData.Habits.run)
    }
    
    private func setup(habit: Habit) {
        fillData(using: habit)
        startLoading()
        
        setupRemindTime(for: habit) { [weak self] _ in
            self?.endLoading()
        }
    }
    
    private func fillData(using habit: Habit) {
        titleInputView.text = habit.title
        notesInputView.text = habit.notes
        scheduleView.selectedDays = habit.schedule
        colorsViewController.set(selected: habit.color)
        iconsViewController.select(icon: habit.habitIcon)
        iconsViewController.setup(color: habit.color)
        durationView.set(startDate: habit.startDate, durationDays: habit.durationDays)
    }
    
    private func setupRemindTime(for habit: Habit, completion: Closure<RResult<Void>>?) {
        interactor.loadRemindTime(for: habit) { [weak self] result in
            defer {
                completion?(.success(Void()))
            }
            guard let date = result.value else {
                return
            }
            self?.set(remind: date)
        }
    }
    
    private func set(remind date: Date) {
        defer {
            handleRemindViewStateUpdate()
        }
        datePickerView.setDate(date, animated: true)
        remindView.set(isOn: true)
    }
    
    // MARK: - Remind View Logic
    private func handleRemindViewStateUpdate() {
        guard remindView.isOn else {
            configureDatePicker(for: false)
            return
        }
        
        remindView.startLoading()
        Notifications.shared.checkDeviceCanReceiveNotifications { [weak self] enabled in
            let randomDelayTime = Int.random(in: 200...400)
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(randomDelayTime)) {
                guard let strongSelf = self, enabled else {
                    self?.handleNotificationsDisabled()
                    return
                }
                
                strongSelf.configureDatePicker(for: true)
                strongSelf.remindView.endLoading()
            }
        }
    }
    
    private func handleNotificationsDisabled() {
        remindView.endLoading()
        remindView.set(isOn: false)
        
        displayNotificationPermission()
    }
    
    private func displayNotificationPermission() {
        let cancelAction: AlertAction = .cancel(title: L10n.Common.cancel, onAction: nil)
        let enableAction: AlertAction = .init(
            title: L10n.Common.enable,
            isPreferred: true,
            style: .default) {
                Notifications.shared.openAppInDeviceSettings()
            }
        let model = AlertModel(title: L10n.Habit.Notifications.Disabled.title,
                               message: L10n.Habit.Notifications.Disabled.message,
                               actions: [enableAction, cancelAction])
        showAlert(by: model)
    }
    
    private func configureDatePicker(for remindEnabled: Bool) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.datePickerView.isHidden = !remindEnabled
        }
    }
        
}
