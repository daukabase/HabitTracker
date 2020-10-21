//
//  HabitDetailsViewController.swift
//  HabitTracker
//
//  Created by Daulet on 4/25/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit
import Promises

final class HabitDetailsViewController: UIViewController, LoaderViewDisplayable {
    
    // MARK: - Properties
    private static let queue = DispatchQueue.global(qos: .userInteractive)
    
    private var interactor: HabitDetailsInteractorInput = HabitDetailsInteractor()
    
    // MARK: - Views
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
        picker.timeZone = .current
        
        if #available(iOS 13.4, *) {
            picker.preferredDatePickerStyle = .wheels
        }
        
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
    
    // MARK: - UIViewController
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
                self?.navigationController?.popToRootViewController(animated: true)
            }
        }
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
        
}
