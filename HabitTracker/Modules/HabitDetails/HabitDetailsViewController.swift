//
//  HabitDetailsViewController.swift
//  HabitTracker
//
//  Created by Daulet on 4/25/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

class HabitDetailsViewController: UIViewController {
    
    @IBOutlet var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonInit()
        setupViews()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func commonInit() {
        title = "Habit details"
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = ColorName.uiBlue.color
        navigationController?.navigationBar.roundCorners([.bottomLeft, .bottomRight], radius: 24)
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: FontFamily.Gilroy.medium.font(size: 24)!,
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        
        setBackButton(style: .orange)
    }
    
    func setupViews() {
        let titleInputView = BaseInputView(frame: .zero)
        titleInputView.setup(title: "Title", placeholder: "Enter title")
        stackView.addArrangedSubview(titleInputView)
        
        let notesInputView = BaseInputView(frame: .zero)
        notesInputView.setup(title: "Notes", placeholder: "Description")
        stackView.addArrangedSubview(notesInputView)
        
        let durationView = DurationView(frame: .zero)
        durationView.setup(title: "Duration")
        stackView.addArrangedSubview(durationView)

        let scheduleView = ScheduleView(frame: .zero)
        scheduleView.titleLabel.text = "Schedule"
        stackView.addArrangedSubview(scheduleView)

        let chooseAllView = SwitchableView(frame: .zero)
        chooseAllView.label.text = "Choose everyday"
        chooseAllView.onStateChanged = { [weak scheduleView] isOn in
            if isOn {
                scheduleView?.selectAllDays()
            } else {
                scheduleView?.deselectAllDays()
            }
        }
        stackView.addArrangedSubview(chooseAllView)
        
        let remindView = SwitchableView(frame: .zero)
        remindView.label.text = "Remind me"
        stackView.addArrangedSubview(remindView)
        
        let backController = BackgroundImagesViewController()
        addChild(backController)
        
        stackView.addArrangedSubview(backController.view)
        stackView.setCustomSpacing(16, after: backController.view)
        
        let saveButton = UIButton(frame: .zero)
        saveButton.apply(style: .blue)
        saveButton.title = "Save"
        saveButton.snp.makeConstraints { (make) in
            make.height.equalTo(50)
        }
        
        stackView.addArrangedSubview(saveButton)
        stackView.setCustomSpacing(38, after: saveButton)
    }

}
