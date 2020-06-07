//
//  InfoDisplayable.swift
//  MoveOn
//
//  Created by Daulet on 24/10/2019.
//  Copyright © 2019 daukabase. All rights reserved.
//

import Foundation

protocol InfoDisplayable {
    func show(message: String)
}

extension InfoDisplayable {
    
    func show(message: String) {
        MessageManager.shared.showMessage(message, type: .info)
    }
    
}
