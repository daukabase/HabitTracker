//
//  UITextField.swift
//  HabitTracker
//
//  Created by Daulet on 4/26/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

extension UITextField {
    
    // MARK: - Input Additional Behavior
    public func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: .zero)
        doneToolbar.frame.size = CGSize(width: UIScreen.main.bounds.width,
                                        height: 50)
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done",
                                                    style: .done,
                                                    target: self,
                                                    action: #selector(doneButtonDidTap))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        inputAccessoryView = doneToolbar
    }
    
    // MARK: - Private actions
    @objc
    private func doneButtonDidTap() {
        resignFirstResponder()
    }
    
}
