//
//  PickerUsageView.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 2/20/21.
//  Copyright © 2021 Daulet. All rights reserved.
//

import UIKit

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
    
    override func enable() {
        super.enable()
        hiddenTextField.isUserInteractionEnabled = true
    }
    
    override func disable() {
        super.disable()
        hiddenTextField.isUserInteractionEnabled = false
    }
}
