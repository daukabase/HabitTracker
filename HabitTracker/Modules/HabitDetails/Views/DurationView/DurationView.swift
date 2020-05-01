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
    private(set) var durationDays: Int = 21
    
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker(frame: .zero)
        
        picker.minimumDate = Date()
        picker.datePickerMode = .date
        picker.locale = Locale(identifier: "ru_RU")
        picker.addTarget(self, action: #selector(updateTextField), for: .valueChanged)
        
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
        durationTextField.delegate = self
        durationTextField.keyboardType = .numberPad
        durationTextField.addDoneButtonOnKeyboard()
        durationTextField.addTarget(self, action: #selector(didChangeDuration(_:)), for: .editingChanged)
        durationTextField.text = String(durationDays)
        durationTextField.tintColor = ColorName.uiBlue.color
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
        let durationDays = Int(textField.text?.digits ?? "") ?? 0
        self.durationDays = durationDays
    }
    
}

extension DurationView: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let newPosition = textField.endOfDocument
        textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
        return true
    }
    
}
