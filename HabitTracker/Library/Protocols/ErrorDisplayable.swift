//
//  ErrorDisplayable.swift
//  MoveOn
//
//  Created by Daulet on 06/02/2019.
//  Copyright © 2019 daukabase. All rights reserved.
//

import Foundation


/// Describes object that can show errors, using MessageManager
protocol ErrorDisplayable: class {
    func showError(describedBy error: Error)
    func showError(describedBy string: String)
}

extension ErrorDisplayable {
    func showError(describedBy error: Error) {
        MessageManager.shared.showMessage(error.localizedDescription)
    }

    func showError(describedBy string: String) {
        MessageManager.shared.showMessage(string)
    }
}
