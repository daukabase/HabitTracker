//
//  DurationView.swift
//  HabitTracker
//
//  Created by Daulet on 4/26/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

final class DurationView: UIView {
    
    private(set) var startDate: Date = Date()
    private(set) lazy var durationDays: Int = suggestedDays
    
    private let suggestedDays = 21
    private var suggestedDaysIndex: Int? {
        return durationDaysArray.enumerated().first { (index, value) -> Bool in
            return value == suggestedDays
        }?.offset
    }
    private let durationDaysArray: [Int] = [5, 7, 13, 21, 48, 66, 85, 256]
    
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker(frame: .zero)
        
        picker.minimumDate = Date()
        picker.datePickerMode = .date
        picker.locale = Locale(identifier: "ru_RU")
        picker.addTarget(self, action: #selector(updateTextField), for: .valueChanged)
        
        return picker
    }()
    
    lazy var durationPickerView: UIPickerView = {
        let picker = UIPickerView(frame: .zero)
        
        picker.delegate = self
        picker.dataSource = self
        if let suggestedDaysIndex = suggestedDaysIndex {
            picker.selectRow(suggestedDaysIndex, inComponent: 0, animated: false)
        }
        return picker
    }()
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var durationContentView: UIView!
    @IBOutlet private var durationTextField: UITextField!
    @IBOutlet private var startTimeContentView: UIView!
    @IBOutlet private var startTimeTextField: UITextField!
    
    @IBOutlet var views: [UIView]!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func setup(title: String) {
        titleLabel.text = title
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
        
        setStartTitle(for: startDate)
        datePicker.date = startDate
        
        startTimeTextField.inputView = datePicker
        startTimeTextField.addDoneButtonOnKeyboard()
        startTimeTextField.tintColor = .clear
        
        durationTextField.placeholder = "0"
        durationTextField.text = "\(suggestedDays)"
        durationTextField.tintColor = .clear
        durationTextField.addDoneButtonOnKeyboard()
        durationTextField.inputView = durationPickerView
    }
    
    private func setStartTitle(for date: Date) {
        startTimeTextField.text = date.string(with: .ddMMYYYY)
    }
    
    // MARK: - Actions
    @objc
    private func updateTextField(_ sender: Any?) {
        startDate = datePicker.date
        setStartTitle(for: datePicker.date)
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
        durationDays = durationDaysArray[row]
        durationTextField.text = "\(durationDaysArray[row])"
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
        return durationDaysArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 1 {
            return "days"
        }
        return String(durationDaysArray[row])
    }
    
}
