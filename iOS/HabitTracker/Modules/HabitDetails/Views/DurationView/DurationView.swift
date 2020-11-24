//
//  DurationView.swift
//  HabitTracker
//
//  Created by Daulet on 4/26/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

final class DurationView: UIView {
    
    // MARK: - Constants
    enum Constants {
        static let suggestedDays = durationDaysArray[suggestedDaysIndex]
        static let suggestedDaysIndex = 3
        static let durationDaysArray: [Int] = [5, 7, 13, 21, 48, 66, 85, 256]
    }
    
    // MARK: - Properties
    private(set) var startDate: Date = Date() {
        didSet {
            updateUI()
        }
    }
    private(set) var durationDays: Int = Constants.suggestedDays {
        didSet {
            updateDuration()
        }
    }
    
    // MARK: - Views
    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker(frame: .zero)
        
        picker.minimumDate = Date()
        picker.datePickerMode = .date
        picker.locale = Locale(identifier: "ru_RU")
        picker.addTarget(self, action: #selector(updateTextField), for: .valueChanged)
        
        if #available(iOS 13.4, *) {
            picker.preferredDatePickerStyle = .wheels
        }
        
        return picker
    }()
    
    private lazy var durationPickerView: UIPickerView = {
        let picker = UIPickerView(frame: .zero)
        
        picker.delegate = self
        picker.dataSource = self
        
        return picker
    }()
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var durationContentView: UIView!
    @IBOutlet private var durationTextField: UITextField!
    @IBOutlet private var startTimeContentView: UIView!
    @IBOutlet private var startTimeTextField: UITextField!
    @IBOutlet private var calendarIconImageView: UIImageView!
    
    @IBOutlet private var views: [UIView]!

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Internal Methods
    func setup(title: String) {
        titleLabel.text = title
    }
    
    func set(startDate: Date, durationDays: Int) {
        self.startDate = startDate
        self.durationDays = durationDays
    }
    
    // MARK: - Private methods
    private func commonInit() {
        initFromNib()
        views.forEach { view in
            view.backgroundColor = nil
            view.roundCorners(.allCorners, radius: view.frame.height / 2)
            view.layer.borderColor = ColorName.uiBlue.color.cgColor
            view.layer.borderWidth = 1
        }
        
        startTimeTextField.inputView = datePicker
        startTimeTextField.addDoneButtonOnKeyboard()
        startTimeTextField.tintColor = .clear
        
        durationTextField.placeholder = "0"
        durationTextField.tintColor = .clear
        durationTextField.addDoneButtonOnKeyboard()
        durationTextField.inputView = durationPickerView
        
        startDate = { startDate }()
        durationDays = { durationDays }()
    }
    
    private func setStartTitle(for date: Date) {
        startTimeTextField.text = date.string(with: .ddMMYYYY)
        guard date < Date() else {
            return
        }
        startTimeTextField.isEnabled = false
        startTimeTextField.textColor = ColorName.textSecondary.color
        calendarIconImageView.image = Asset.calendar.image.filled(with: ColorName.textSecondary.color)
        startTimeContentView.layer.borderColor = ColorName.textSecondary.color.cgColor
    }
    
    private func updateUI() {
        setStartTitle(for: startDate)
        datePicker.date = startDate
    }
    
    private func updateDuration() {
        guard let durationIndex = Constants.durationDaysArray.firstIndex(where: { daysCount in
            return daysCount == durationDays
        }) else {
            return
        }
        
        durationTextField.text = "\(Constants.durationDaysArray[durationIndex])"
        durationPickerView.selectRow(durationIndex, inComponent: 0, animated: false)
    }
    
    // MARK: - Actions
    @objc
    private func updateTextField(_ sender: Any?) {
        updateUI()
    }
    
    @objc
    private func didChangeDuration(_ textField: UITextField) {
        
    }
    
}

extension DurationView: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let newPosition = textField.endOfDocument
        textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
        return true
    }
    
}

extension DurationView: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        durationDays = Constants.durationDaysArray[row]
        durationTextField.text = "\(Constants.durationDaysArray[row])"
    }
    
}

extension DurationView: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 1 {
            return 1
        }
        return Constants.durationDaysArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 1 {
            return "days"
        }
        return String(Constants.durationDaysArray[row])
    }
    
}
