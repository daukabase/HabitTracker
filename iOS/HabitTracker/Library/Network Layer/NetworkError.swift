//
//  Network.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 7/19/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation

public typealias JSONDictionary = [String: Any]

public func dataToObject<T: Decodable>(data: Data,
                                object type: T,
                                dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .iso8601) -> Result<T, Error> {
    do {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        
        let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
        let object = try decoder.decode(T.self, from: jsonData)
        
        return .success(object)
    } catch {
        return .failure(HError.notAnObject)
    }
}

public func dataToJson(data: Data) -> Result<JSONDictionary, Error> {
    do {
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        guard let json = jsonObject as? JSONDictionary else {
            return .failure(HError.notAnObject)
        }
        
        return .success(json)
    } catch {
        return .failure(HError.notAnObject)
    }
}

public extension Result {
    
    var success: Success? {
        switch self {
        case let .success(value):
            return value
        case .failure:
            return nil
        }
    }
    
    var failure: Failure? {
        switch self {
        case .success:
            return nil
        case let .failure(value):
            return value
        }
    }
    
}

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

public extension JSONDictionary {
    
    subscript(dict key: String) -> JSONDictionary? {
        return self[key] as? JSONDictionary
    }
    
    subscript<T>(_ key: String, type: T.Type) -> T? {
        return self[key] as? T
    }
    
}

enum HError: Error {
    case notAnObject
}

enum HErrorCode: CustomStringConvertible {
    
    case jsonMapping
    case statusCode(Int)
    case data
    case networkFailure
    
    var intValue: Int {
        switch self {
        case .jsonMapping: return 0
        case let .statusCode(code): return code
        case .data: return 1
        case .networkFailure: return 2
        }
    }
    
    var description: String {
        switch self {
        case .jsonMapping:
            return "JSON mapping"
        default:
            return "Unknown mapping"
        }
    }
    
}

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
    
    class func networkError(_ error: ErrorModel?, code: HErrorCode) -> NSError {
        return NSError(domain: hErrorDomain,
                       code: code.intValue,
                       userInfo: error?.localizedUserInfo())
    }
    
}

enum LocalizedFailure: String {
    case devMessage
    case message
    case code
    
    var key: String {
        return self.rawValue
    }
}

struct ErrorModel: Codable {
    
    let code: String?
    let message: String
    let devMessage: String
    
    init(code: String, message: String, devMessage: String) {
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


extension NetworkProvider {
    
    static func generateError(data: Data, statusCode: Int?) -> NSError {
        let code: HErrorCode = statusCode.map { .statusCode($0) } ?? .data
        let errorModel = try? JSONDecoder().decode(ErrorModel.self, from: data)
        
        return NSError.networkError(errorModel, code: code)
    }
    
}

