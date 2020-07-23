//
//  NetworkProvider+Error.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 7/19/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation

public var hErrorDomain: String = {
    /*
     Best practice for naming error domain is to
     reverse-DNS style domain
     See, https://stackoverflow.com/a/3276356/10799983
    */
    return Config.baseUrl
        .absoluteString
        .split(separator: ".")
        .reversed()
        .joined()
}()

extension NSError {
    
    class func networkError(_ error: Any?, code: HErrorCode) -> NSError {
        var userInfo: [String: Any]?
        if let error = error {
            userInfo = [NSLocalizedFailureReasonErrorKey: error]
        } else {
            userInfo = [NSLocalizedFailureReasonErrorKey: "\(code)"]
        }
        return NSError(domain: hErrorDomain, code: code.intValue, userInfo: userInfo)
    }
    
    class func networkError(_ error: HErrorModel?, code: HErrorCode) -> NSError {
        return NSError(domain: hErrorDomain,
                       code: code.intValue,
                       userInfo: error?.localizedUserInfo())
    }
    
}

extension NetworkProvider {
    
    static func generateError(data: Data, statusCode: Int?) -> NSError {
        let code: HErrorCode = statusCode.map { .statusCode($0) } ?? .data
        let errorModel = try? JSONDecoder().decode(HErrorModel.self, from: data)
        
        return NSError.networkError(errorModel, code: code)
    }
    
}
