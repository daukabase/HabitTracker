//
//  HabitDetailsViewController.swift
//  HabitTracker
//
//  Created by Daulet on 4/25/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit
import Promises

final class HabitDetailsViewController: UIViewController, LoaderViewDisplayable, InfoDisplayable {
    
    // MARK: - Nested Types
    enum Context {
        case createNew
        case edit(Habit)
    }
    
    // MARK: - Properties
    private static let queue = DispatchQueue.global(qos: .userInteractive)
    
    private var interactor: HabitDetailsInteractorInput = HabitDetailsInteractor()
    private let context: Context
    
    // MARK: - Views
    @IBOutlet private var stackView: UIStackView!
    
    private lazy var titleInputView: BaseInputView = {
        let titleInputView = BaseInputView(frame: .zero)
        titleInputView.setup(title: "Title", placeholder: "Enter title")
        
        return titleInputView
    }()
    
    private lazy var notesInputView: BaseInputView = {
        let notesInputView = BaseInputView(frame: .zero)
        notesInputView.setup(title: "Notes", placeholder: "Description")
        
        return notesInputView
    }()
    
    private lazy var durationView: DurationView = {
        let durationView = DurationView(frame: .zero)
        durationView.setup(title: "Duration")
        return durationView
    }()
    
    private lazy var scheduleView: ScheduleView = {
        let scheduleView = ScheduleView(frame: .zero)
        scheduleView.title = "Schedule"
        scheduleView.onChange = { [weak self] in
            self?.changedSchedule()
        }
        return scheduleView
    }()
    
    private lazy var chooseAllView: SwitchableView = {
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
    
    private lazy var remindView: SwitchableView = {
        let remindView = SwitchableView(frame: .zero)
        remindView.label.text = "Remind me"
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
        saveButton.title = "Save"
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
        
        iconsViewController.setup(color: colorsViewController.selectedColor)
        colorsViewController.onColor = { [weak iconsViewController] color in
            iconsViewController?.setup(color: color)
        }
        
        commonInit()
        setupViews()
        setupContext()
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
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Init
    init(context: Context) {
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

    // MARK: - Actions
    @objc
    private func didTapActionButton() {
        guard isAllDataFilled() else {
            return
        }
        
        startLoading(isTransparentBackground: true)
        createHabit()
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
    
    private func isAllDataFilled() -> Bool {
        guard
            titleInputView.text.isEmpty ||
                notesInputView.text.isEmpty || scheduleView.selectedDays.isEmpty else {
            return true
        }
        
        showAlert(title: "Oops", message: "Please, fill all data to continue")
        
        return false
    }
    
    private func getHabit() -> HabitModel {
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
        
        return habit
    }
    
    private func setupContext() {
        switch context {
        case .createNew:
            break
        case let .edit(habit):
            fillData(using: habit)
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
