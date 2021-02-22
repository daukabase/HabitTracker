//
//  StartDateView.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 2/22/21.
//  Copyright © 2021 Daulet. All rights reserved.
//

import UIKit

class StartDateView: PickerIntegratableView {
    
    var startDate: Date = Date() {
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
        updateUI()
        set(title: "Start date")
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
