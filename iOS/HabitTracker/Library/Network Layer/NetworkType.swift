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
        return Network(provider: networkProvider(plugins))
    }
    
    public static var plugins: [PluginType] {
        return []
    }
    
    public static func endpointsClosure<T>() -> (T) -> Endpoint where T: SugarTargetType {
        return { target in
            let endpoint: Endpoint = Endpoint(url: url(target).removingPercentEncoding!,
                                              sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                                              method: target.method,
                                              task: target.task,
                                              httpHeaderFields: target.headers)
            return endpoint
        }
    }
    
    public static func endpointResolver() -> MoyaProvider<T>.RequestClosure {
        return { endpoint, closure in
            do {
                var request = try endpoint.urlRequest()
                request.httpShouldHandleCookies = false
                
                closure(.success(request))
            } catch {
                closure(.failure(MoyaError.underlying(error, nil)))
            }
        }
    }
    
    public static func networkProvider<T>(_ plugins: [PluginType]) -> NetworkProvider<T> where T: SugarTargetType {
        return NetworkProvider(endpointClosure: Network<T>.endpointsClosure(),
                               requestClosure: Network<T>.endpointResolver(),
                               stubClosure: MoyaProvider.immediatelyStub,
                               callbackQueue: nil,
                               session: .default,
                               plugins: plugins)
    }
    
}

public func url(_ route: Moya.TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}
