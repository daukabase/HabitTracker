//
//  ErrorModel.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 7/23/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation

struct ErrorModel: Codable {

    private enum LocalizedFailure: String {
        case devMessage
        case message
        case code
        
        var key: String {
            return self.rawValue
        }
    }
    
    let code: String?
    let message: String
    let devMessage: String?
    
    init(code: String, message: String, devMessage: String?) {
        self.code = code
        self.message = message
        self.devMessage = devMessage
    }
    
    func localizedUserInfo() -> [String: Any] {
        var userInfo = [String: Any]()
        
        userInfo[LocalizedFailure.devMessage.key] = devMessage
        userInfo[LocalizedFailure.code.key] = code
        userInfo[LocalizedFailure.message.key] = message
        userInfo[NSLocalizedDescriptionKey] = message
        
        return userInfo
    }
    
}
