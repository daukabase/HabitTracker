//
//  InputTextField.swift
//  HabitTracker
//
//  Created by Nurbek Ismagulov on 7/26/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import SkyFloatingLabelTextField
import UIKit

class InputTextField: SkyFloatingLabelTextFieldWithIcon {
    var onErrorHide: (() -> Void)?
    
    fileprivate let baseSidePadding: CGFloat = 0
    fileprivate let titleTopPadding: CGFloat = 4
    
    fileprivate let cursorPadding = UIEdgeInsets(top: 4, left: 0, bottom: 0, right: 10)
    fileprivate let textPadding = UIEdgeInsets(top: 4, left: 0, bottom: 0, right: 10)
    fileprivate let basePadding = UIEdgeInsets(top: 4, left: 0, bottom: 0, right: 10)
    
    fileprivate let lineYPostionDeviation: CGFloat = -20
    
    // MARK: - Initialization
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: - Public methods
    public func commonInit() {
        backgroundColor = ColorName.uiWhite.color
        tintColor = ColorName.textPrimary.color
        
        errorMessagePlacement = .bottom
        errorColor = ColorName.uiRed.color
        errorLabel.font = FontFamily.Gilroy.regular.font(size: 12)
        errorLabel.adjustsFontSizeToFitWidth = true
        errorLabel.minimumScaleFactor = 0.8
        
        titleFormatter = { $0 }
        
        lineColor = ColorName.uiGraySecondary.color
        lineErrorColor = ColorName.uiRed.color
        lineHeight = 1
        
        titleFont = FontFamily.Gilroy.regular.font(size: 12)
        titleFadeInDuration = 0.15
        titleFadeOutDuration = 0.2
        
        selectedTitleColor = ColorName.textSecondary.color
        selectedLineColor = ColorName.icons.color
        
        // Text
        font = FontFamily.Gilroy.semibold.font(size: 15)
        textColor = ColorName.textPrimary.color
        textErrorColor = ColorName.uiRed.color

        // Placeholder
        placeholderFont = FontFamily.Gilroy.semibold.font(size: 15)
        placeholderColor = ColorName.textSecondary.color
    }
    
    // MARK: - SkyFloatingLabelTextField
    public override func updateColors() {
        super.updateColors()
    }
    
    public override func errorHeight() -> CGFloat {
        return 24
    }
    
    @objc
    public override func editingChanged() {
        super.editingChanged()
        hideErrorMessage()
    }
    
    public override func lineViewRectForBounds(_ bounds: CGRect, editing: Bool) -> CGRect {
        var frame = super.lineViewRectForBounds(bounds, editing: editing)
        frame.origin.y = frame.origin.y.advanced(by: lineYPostionDeviation)
        return frame
    }
    
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        guard !isPlaceHolderEmpty() else {
            return bounds.inset(by: basePadding)
        }
        return bounds.inset(by: textPadding)
    }
    
    public override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        if hasErrorMessage {
            return bounds.inset(by: textPadding)
        }
        return bounds.inset(by: basePadding)
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        guard !isPlaceHolderEmpty() else {
            return bounds.inset(by: basePadding)
        }
        if text?.isEmpty ?? false {
            return bounds.inset(by: hasErrorMessage ? textPadding : cursorPadding)
        }
        return bounds.inset(by: textPadding)
    }
    
    public override func titleLabelRectForBounds(_ bounds: CGRect, editing: Bool) -> CGRect {
        if editing {
            return CGRect(x: baseSidePadding, y: titleTopPadding, width: bounds.size.width, height: titleHeight())
        }
        return bounds.inset(by: UIEdgeInsets(top: 0, left: baseSidePadding, bottom: 0, right: 0))
    }
    
    // MARK: - Private methods
    private func hideErrorMessage() {
        errorMessage = ""
        onErrorHide?()
    }
    
    private func isPlaceHolderEmpty() -> Bool {
        guard let placeholder = placeholder else { return true }
        return placeholder.isEmpty
    }
    
}
