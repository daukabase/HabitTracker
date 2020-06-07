//
//  NumberRegistrationViewController.swift
//  HabitTracker
//
//  Created by Daulet on 5/3/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

final class NumberRegistrationViewController: UIViewController, Maskable {
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var continueButton: UIButton!
    @IBOutlet var checkImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackButton(style: .orange)
        textField.delegate = self
        textField.keyboardType = .numberPad
        textField.placeholder = phoneNumberMask
        
        continueButton.apply(style: .blue)
        continueButton.isEnabled = false
        checkImageView.alpha = 0
    }
    
}

extension NumberRegistrationViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {
            return false
        }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        
        let phoneNumberCasted = getMasked(from: newString)
        textField.text = phoneNumberCasted
        
        let isNumberFilled = getIsFulfilled(value: phoneNumberCasted)
        updateUI(for: isNumberFilled)
        
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard textField.text?.isEmpty ?? false else {
            return
        }
        textField.text = "+7"
    }
    
}

extension NumberRegistrationViewController {
    
    @IBAction
    private func didClickContinuesButton() {
        guard let controller = UIStoryboard.instantiate(ofType: NumberConfirmationViewController.self) else {
            return
        }
        
        controller.model = NumberConfirmationViewModel(phoneNumber: textField.text ?? "")
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func updateUI(for fulfilled: Bool) {
        UIView.animate(withDuration: 0.1) {
            self.checkImageView.alpha = fulfilled ? 1 : 0
            self.continueButton.isEnabled = fulfilled
            self.continueButton.layoutIfNeeded()
        }
    }
    
}
