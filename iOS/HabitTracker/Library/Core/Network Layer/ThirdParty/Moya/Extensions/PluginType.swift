//
//  PluginType.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 7/22/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation
import Moya

extension PluginType {
    
    func getSupplemented(request: URLRequest, type: NetworkRequestType) -> URLRequest {
        var request = request
        
        request.add(headers: type.headers)
        
        return request
    }
    
}
