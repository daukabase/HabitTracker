//
//  SharedMethods.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 7/23/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation
import Moya

public typealias JSONDictionary = [String: Any]

public func dataToObject<T: Decodable>(data: Data,
                                       object type: T.Type,
                                       dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .iso8601) -> Result<T, Error> {
    do {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        
        let object = try decoder.decode(T.self, from: data)
        
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

public func url(_ route: Moya.TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}
