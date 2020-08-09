//
//  NetworkType.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 7/19/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation
import Moya

public typealias MoyaResult = Result<Moya.Response, Moya.MoyaError>

public protocol NetworkType {
    associatedtype T: SugarTargetType
    var provider: NetworkProvider<T> { get }
}

extension NetworkType {
    
    public static var defaultNetwork: Network<T> {
        return Network(provider: networkProvider([
            AuthPlugin()
        ]))
    }
    
    public static var endpointAccessNetwork: Network<T> {
        return Network(provider: networkProvider([
            AuthEndpointAccessPlugin()
        ]))
    }
    
    public static var networkWithoutPlugins: Network<T> {
        return Network(provider: networkProvider([]))
    }
    
    public static func endpointsClosure<T>() -> (T) -> Endpoint where T: SugarTargetType {
        return MoyaProvider.defaultEndpointMapping
    }
    
    public static func requestClosure() -> MoyaProvider<T>.RequestClosure {
        return MoyaProvider<T>.defaultRequestMapping
    }
    
    public static func networkProvider<T>(_ plugins: [PluginType]) -> NetworkProvider<T> where T: SugarTargetType {
        return NetworkProvider(endpointClosure: Network<T>.endpointsClosure(),
                               requestClosure: Network<T>.requestClosure(),
                               stubClosure: MoyaProvider.neverStub,
                               callbackQueue: nil,
                               session: MoyaProvider<T>.defaultAlamofireSession(),
                               plugins: plugins)
    }
    
}
