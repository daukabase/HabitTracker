//
//  BaseInputView.swift
//  HabitTracker
//
//  Created by Daulet on 4/25/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import UIKit

final class BaseInputView: UIView {

    var onChange: Closure<String>?

    var placeholderAttributes: [StringAttribute] {
        return [
            .font(FontFamily.Gilroy.regular.font(size: 18)),
            .foregroundColor(ColorName.uiGraySecondary.color)
        ]
    }
    
    var text: String {
        get {
            textField.text ?? ""
        }
        set {
            textField.text = newValue
        }
    }
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var textField: UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func setup(title: String, placeholder: String) {
        self.titleLabel.text = title
        self.textField.attributedPlaceholder = placeholder.with(attributes: placeholderAttributes)
    }

    private func commonInit() {
        initFromNib()
        textField.addTarget(self,
                            action: #selector(textFieldDidChange(_:)),
                            for: .editingChanged)
    }
    
    // MARK: - Actions
    @objc
    private func textFieldDidChange(_ textField: UITextField) {
        onChange?(textField.text ?? "")
    }
    
}
