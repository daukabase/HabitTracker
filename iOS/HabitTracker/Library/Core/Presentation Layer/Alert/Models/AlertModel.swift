//
//  AlertModel.swift
//  Business
//
//  Created by Daulet Almagambetov on 8/13/20.
//  Copyright © 2020 AO Alfa-Bank. All rights reserved.
//

import UIKit

public struct AlertModel {
    
    // MARK: - Constants
    public let title: String
    public let message: String
    public let actions: [UIAlertAction]
    public let preferredAction: UIAlertAction?
    
    // MARK: - Init
    public init(title: String, message: String, actions: [AlertAction]) {
        let uiActions = actions.map { $0.generateUiAlertAction() }
        let preferredActionIndex = actions.firstIndex(where: { $0.isPreferred })
        let preferredAction = preferredActionIndex.map { uiActions[$0] }
        
        self.title = title
        self.message = message
        self.actions = uiActions
        self.preferredAction = preferredAction
    }
    
    public init(title: String,
                message: String,
                confirmationTitle: String,
                onConfirm: Block?) {
        let cancelAction: AlertAction = .cancel()
        let confirmAction = AlertAction(title: confirmationTitle, onAction: onConfirm)
        
        self.init(title: title, message: message, actions: [confirmAction, cancelAction])
    }
    
}
