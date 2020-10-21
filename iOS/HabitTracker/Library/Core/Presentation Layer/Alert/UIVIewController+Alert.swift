//
//  UIVIewController+Alert.swift
//  Business
//
//  Created by Nurkhat Pazylov on 10/29/19.
//  Copyright © 2019 AO Alfa-Bank. All rights reserved.
//

import Haptica
import SwiftEntryKit

extension UIViewController {

    // MARK: - Constants
    private enum Constant {
        enum Attribute {
            static var topSuccess: EKAttributes = {
                var attributes = EKAttributes.topNote
                attributes.statusBar = .light
                attributes.displayDuration = 2
                attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
                attributes.entryBackground = .color(color: EKColor(ColorName.uiGreenSuccess.color))
                attributes.positionConstraints.safeArea = .empty(fillSafeArea: true)
                attributes.positionConstraints.size = .init(width: .fill, height: .intrinsic)
                return attributes
            }()
            static var topToast: EKAttributes = {
                var attributes = EKAttributes.topNote
                attributes.statusBar = .light
                attributes.displayDuration = 5
                attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
                attributes.entryBackground = .color(color: EKColor(ColorName.uiRed.color))
                attributes.positionConstraints.safeArea = .empty(fillSafeArea: true)
                attributes.positionConstraints.size = .init(width: .fill, height: .intrinsic)
                return attributes
            }()
            static var infiniteTopToast: EKAttributes = {
                var attributes = EKAttributes.topNote
                attributes.statusBar = .light
                attributes.displayDuration = .infinity
                attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
                attributes.entryBackground = .color(color: EKColor(ColorName.uiRed.color))
                attributes.positionConstraints.safeArea = .empty(fillSafeArea: true)
                attributes.positionConstraints.size = .init(width: .fill, height: .intrinsic)
                return attributes
            }()
            static var infiniteCenterAlert: EKAttributes = {
                var attributes = EKAttributes.centerFloat
                attributes.statusBar = .light
                attributes.displayDuration = .infinity
                attributes.entryBackground = .clear
                attributes.entryInteraction = .absorbTouches
                attributes.position = .center
                attributes.positionConstraints.size = .init(width: .offset(value: 24), height: .intrinsic)
                attributes.screenBackground = .color(color: EKColor(ColorName.uiPrimary.color.withAlphaComponent(0.75)))
                attributes.screenInteraction = .dismiss
                attributes.scroll = .disabled
                attributes.windowLevel = .alerts
                return attributes
            }()
        }
    }

    // MARK: - Methods

    func showToast(type: AlertView.ViewType, message: String? = nil) {
        switch type {
        case .success:
            Haptic.play([.haptic(.notification(.success))])
            let view = AlertView(type: .success)
            view.configure(with: message)
            SwiftEntryKit.display(entry: view, using: Constant.Attribute.topSuccess)
        case .error:
            Haptic.play([.haptic(.notification(.error))])
            let view = AlertView(type: .error)
            view.configure(with: message)
            SwiftEntryKit.display(entry: view, using: Constant.Attribute.topToast)
        case .noInternet:
            let view = AlertView(type: .noInternet)
            view.configure(with: nil)
            SwiftEntryKit.display(entry: view, using: Constant.Attribute.infiniteTopToast)
        }
    }
    
    func showTermsOfUse(title: String, body: String) {
        let view = TermsOfUseView(title: title, body: body)
        SwiftEntryKit.display(entry: view, using: Constant.Attribute.infiniteCenterAlert)
    }

    func hideToast() {
        SwiftEntryKit.dismiss(.all)
    }
}

extension UIViewController {
    
    // MARK: - System Alert
    func showAlert(by model: AlertModel, completion: Block? = nil) {
        let controller = UIAlertController(title: model.title,
                                           message: model.message,
                                           preferredStyle: .alert)
        
        model.actions.forEach(controller.addAction)
        controller.preferredAction = model.preferredAction
        
        DispatchQueue.main.async {
            self.present(controller, animated: true, completion: completion)
        }
    }
    
    func showAlert(title: String, message: String, completion: Block? = nil) {
        let okAction: AlertAction = .cancel(title: L10n.Common.ok, onAction: nil)
        let model = AlertModel(title: title, message: message, actions: [okAction])
        
        showAlert(by: model, completion: completion)
    }
    
    func showAlert(title: String, message: String, confirmationTitle: String, onConfirm: Block?, onCancel: Block? = nil) {
        let cancelAction: AlertAction = .cancel(title: L10n.Common.cancel, onAction: onCancel)
        let confirmAction = AlertAction(title: confirmationTitle, onAction: onConfirm)
        let model = AlertModel(title: title,
                               message: message,
                               actions: [confirmAction, cancelAction])
        
        showAlert(by: model)
    }
    
}
