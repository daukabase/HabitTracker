//
//  AlertAction.swift
//  Business
//
//  Created by Daulet Almagambetov on 8/13/20.
//  Copyright © 2020 AO Alfa-Bank. All rights reserved.
//

import UIKit

public final class AlertAction {
    
    // MARK: - Constants
    public let title: String
    public let isPreferred: Bool
    public let style: UIAlertAction.Style
    public let onAction: EmptyClosure?
    
    // MARK: - Initialization
    public init(title: String, isPreferred: Bool = false, style: UIAlertAction.Style = .default, onAction: EmptyClosure?) {
        self.title = title
        self.isPreferred = isPreferred
        self.style = style
        self.onAction = onAction
    }
    
    // MARK: - Internal Methods
    public func generateUiAlertAction() -> UIAlertAction {
        return UIAlertAction(title: title, style: style) { [onAction] action in
            onAction?()
        }
    }
    
    // MARK: - Static Methods
    static func cancel(title: String = L10n.Common.cancel, onAction: EmptyClosure? = nil) -> AlertAction {
        return AlertAction(title: title, isPreferred: false, style: .cancel, onAction: onAction)
    }
    
}
