//
//  NetworkRequestType.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 7/23/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation

enum NetworkRequestType {
    case auth
    case authEndpointAccess
    
    var headers: [Header] {
        var headers = [Header]()
        
        switch self {
        case .auth:
            guard let token = AuthToken.authToken else { break }
        
            headers.append(.authorization(token: token))
        case .authEndpointAccess:
            guard let token = AuthToken.authEndpointAccessToken else { break }
            
            headers.append(.authorization(token: token))
        }
        return headers
    }
}
