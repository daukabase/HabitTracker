//
//  Network.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 7/19/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Moya
import Promises

public typealias NetworkResponse = Data

public struct Network<T: SugarTargetType>: NetworkType {
    
    public let provider: NetworkProvider<T>
    
    public init(provider: NetworkProvider<T>) {
        self.provider = provider
    }
    
}

public extension Network {
    
    func request(with target: T) -> Promise<NetworkResponse> {
        let promise = Promise<NetworkResponse>.pending()
        
        provider.send((target: target, resolve: promise.fulfill, reject: promise.reject(_:)))
        
        return promise
    }
    
    private func putAdditionalHeaders(into headers: inout [String: String]?) {
        
    }
    
}
