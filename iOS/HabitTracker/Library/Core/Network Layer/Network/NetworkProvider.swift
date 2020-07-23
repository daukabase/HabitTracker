//
//  NetworkingProvider.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 7/19/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Moya
import Alamofire

final public class NetworkProvider<T: SugarTargetType>: MoyaProvider<T> {
    
    public typealias NetworkRequestFuture = (target: T, resolve: (Data) -> Void, reject: (Error) -> Void)
    
    private let provider: MoyaProvider<T>
    
    public override init(
        endpointClosure: @escaping MoyaProvider<Target>.EndpointClosure = MoyaProvider<T>.defaultEndpointMapping,
        requestClosure: @escaping MoyaProvider<Target>.RequestClosure = MoyaProvider<T>.defaultRequestMapping,
        stubClosure: @escaping MoyaProvider<Target>.StubClosure = MoyaProvider.neverStub,
        callbackQueue: DispatchQueue?,
        session: Session = .default,
        plugins: [PluginType] = [],
        trackInflights: Bool = false)
    {
        self.provider = MoyaProvider(endpointClosure: endpointClosure,
                                     requestClosure: requestClosure,
                                     stubClosure: stubClosure,
                                     callbackQueue: callbackQueue,
                                     session: session,
                                     plugins: plugins,
                                     trackInflights: trackInflights)
    }
    
    public func send(_ request: NetworkRequestFuture) {
        provider.request(request.target) { [weak self] result in
            self?.handleRequest(request: request, result: result)
        }
    }
    
}

extension NetworkProvider {
    
    private func handleRequest(request: NetworkRequestFuture, result: MoyaResult) {
        print("Handle Request: \(request.target.path)")
        print("Handle Request url: \(request.target)")
        print("Handle Request route.path: \(request.target.route.path)")
        switch result {
        case let .success(moyaResponse):
            switch moyaResponse.statusCode {
            case 200 ... 299, 300 ... 399:
                handleNetworkSuccess(request: request, response: moyaResponse)
            case 401:
                handleAuthorizationError(request: request, response: moyaResponse)
            default:
                handleServerError(request: request, response: moyaResponse)
            }
        case .failure:
            handleNetworkFailure(request: request)
        }
    }
    
    private func handleNetworkSuccess(request: NetworkRequestFuture, response moyaResponse: Moya.Response) {
        _ = moyaResponse.response
        let data = moyaResponse.data
        let statusCode = moyaResponse.statusCode
        print("\(request.target.path) statucCode: \(statusCode)")
        request.resolve(data)
    }
    
    private func handleAuthorizationError(request: NetworkRequestFuture, response moyaResponse: Moya.Response) {
        let data = moyaResponse.data
        let statusCode = moyaResponse.statusCode
        let networkError = NetworkProvider.generateError(data: data, statusCode: statusCode)
        print("Authorization Error: \(networkError) with statusCode \(statusCode)")
        request.reject(networkError)
    }
    
    private func handleServerError(request: NetworkRequestFuture, response moyaResponse: Moya.Response) {
        let data = moyaResponse.data
        let statusCode = moyaResponse.statusCode
        let networkError = NetworkProvider.generateError(data: data, statusCode: statusCode)
        print("Server Error: \(networkError) with statusCode \(statusCode)")
        request.reject(networkError)
    }
    
    private func handleNetworkFailure(request: NetworkRequestFuture) {
        let error = NSError(domain: "domain", code: 123, userInfo: [NSLocalizedFailureReasonErrorKey: "Network eeror"])
        request.reject(error)
    }
    
}
