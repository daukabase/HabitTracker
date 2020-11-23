//
//  UIVIewController+Alert.swift
//  Business
//
//  Created by Nurkhat Pazylov on 10/29/19.
//  Copyright © 2019 AO Alfa-Bank. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // MARK: - System Alert
    func showAlert(by model: AlertModel, completion: EmptyClosure? = nil) {
        let controller = UIAlertController(title: model.title,
                                           message: model.message,
                                           preferredStyle: .alert)
        
        model.actions.forEach(controller.addAction)
        controller.preferredAction = model.preferredAction
        
        DispatchQueue.main.async {
            self.present(controller, animated: true, completion: completion)
        }
    }
    
    func showAlert(title: String, message: String, completion: EmptyClosure? = nil) {
        let okAction: AlertAction = .cancel(title: L10n.Common.ok, onAction: nil)
        let model = AlertModel(title: title, message: message, actions: [okAction])
        
        showAlert(by: model, completion: completion)
    }
    
    func showAlert(title: String, message: String, confirmationTitle: String, onConfirm: EmptyClosure?, onCancel: EmptyClosure? = nil) {
        let cancelAction: AlertAction = .cancel(title: L10n.Common.cancel, onAction: onCancel)
        let confirmAction = AlertAction(title: confirmationTitle, onAction: onConfirm)
        let model = AlertModel(title: title,
                               message: message,
                               actions: [confirmAction, cancelAction])
        
        showAlert(by: model)
    }
    
}
