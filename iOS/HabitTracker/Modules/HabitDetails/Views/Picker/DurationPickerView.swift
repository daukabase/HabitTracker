//
//  DurationPickerView.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 2/22/21.
//  Copyright © 2021 Daulet. All rights reserved.
//

import UIKit

class DurationPickerView: PickerIntegratableView {
    
    // MARK: - Constants
    enum Constants {
        static let suggestedDays = durationDaysArray[suggestedDaysIndex]
        static let suggestedDaysIndex = 3
        static let durationDaysArray: [Int] = [5, 7, 13, 21, 48, 66, 85, 256]
    }
    
    var durationDays: Int = Constants.suggestedDays {
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
        updateDuration()
        set(title: "Duration")
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
