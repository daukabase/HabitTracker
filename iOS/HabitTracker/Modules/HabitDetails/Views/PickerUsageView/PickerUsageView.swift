//
//  PickerUsageView.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 2/20/21.
//  Copyright © 2021 Daulet. All rights reserved.
//

import UIKit

class TitleContentView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = FontFamily.Gilroy.regular.font(size: 16)
        label.textColor = ColorName.uiOrange.color
        
        return label
    }()
    
    
    private lazy var dataLabel: UILabel = {
        let label = UILabel()
        
        label.font = FontFamily.Gilroy.medium.font(size: 16)
        label.textColor = ColorName.textPrimary.color
        
        return label
    }()
    
    init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        [titleLabel, dataLabel].forEach(addSubview)
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        dataLabel.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        snp.makeConstraints { make in
            make.height.equalTo(36)
        }
    }

    func enable() {
        dataLabel.textColor = ColorName.textPrimary.color
    }
    
    func disable() {
        dataLabel.textColor = ColorName.textSecondary.color
    }
    
    func set(title: String) {
        titleLabel.text = title
    }
    
    func set(description: String) {
        self.dataLabel.text = description
    }
    
}

class PickerIntegratableView: TitleContentView {
    
    private lazy var hiddenTextField: UITextField = {
        let field = UITextField()
        return field
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        addSubview(hiddenTextField)
        
        hiddenTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func set(inpuView: UIView) {
        hiddenTextField.inputView = inpuView
        hiddenTextField.addDoneButtonOnKeyboard()
        hiddenTextField.tintColor = .clear
    }
    
}

class StartDateView: PickerIntegratableView {
    
    private(set) var startDate: Date = Date() {
        didSet {
            updateUI()
        }
    }
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func commonInit() {
        set(inpuView: datePicker)
        startDate = { startDate }()
    }
    
    private func updateUI() {
        setStartTitle(for: startDate)
        datePicker.date = startDate
    }
    
    @objc
    private func updateTextField(_ sender: Any?) {
        startDate = datePicker.date
        updateUI()
    }
    
    private func setStartTitle(for date: Date) {
        set(description: date.string(with: .ddMMYYYY))
        guard date < Date(), !Calendar.current.isDateInToday(date) else {
            enable()
            return
        }
        disable()
    }
}

class DurationPickerView: PickerIntegratableView {
    
    // MARK: - Constants
    enum Constants {
        static let suggestedDays = durationDaysArray[suggestedDaysIndex]
        static let suggestedDaysIndex = 3
        static let durationDaysArray: [Int] = [5, 7, 13, 21, 48, 66, 85, 256]
    }
    
    private(set) var durationDays: Int = Constants.suggestedDays {
        didSet {
            updateDuration()
        }
    }
    
    private lazy var pickerView: UIPickerView = {
        let picker = UIPickerView(frame: .zero)
        
        picker.delegate = self
        picker.dataSource = self
        
        return picker
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func updateDuration() {
        guard let durationIndex = Constants.durationDaysArray.firstIndex(where: { daysCount in
            return daysCount == durationDays
        }) else {
            return
        }
        
        set(durationDays: Constants.durationDaysArray[durationIndex])
        pickerView.selectRow(durationIndex, inComponent: 0, animated: false)
    }
    
    private func commonInit() {
        set(inpuView: pickerView)
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        self.pickerView.reloadAllComponents()
    }
    
    private func set(durationDays: Int) {
        set(description: "\(durationDays) days")
    }
    
}

extension DurationPickerView: UIPickerViewDataSource, UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 1 {
            return 1
        }
        return Constants.durationDaysArray.count
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 1 {
            return "days"
        }
        return String(Constants.durationDaysArray[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        durationDays = Constants.durationDaysArray[row]
        set(durationDays: Constants.durationDaysArray[row])
    }
    
}
