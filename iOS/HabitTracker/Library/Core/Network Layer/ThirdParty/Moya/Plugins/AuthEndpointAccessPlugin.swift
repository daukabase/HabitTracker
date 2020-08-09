//
//  AuthEndpointAccessPlugin.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 7/22/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation
import Moya

struct AuthEndpointAccessPlugin: PluginType {
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        return getSupplemented(request: request, type: .authEndpointAccess)
    }
    
}
