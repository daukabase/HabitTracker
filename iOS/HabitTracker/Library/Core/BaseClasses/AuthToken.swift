//
//  AuthToken.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 7/21/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation

public final class AuthToken {
    
    // MARK: - Constants
    private enum Constants {
        static let authEndpointAccessSecretKey = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJuaWtOYW1lIjoibnlhcnIiLCJwYXNzd29yZCI6InRlc3QxMjM0In0.a5N6k26sJmGjqhU9FpUnKjGnbO28GINMgct6F0B0INQ"
    }
    
    // MARK: - Private Static Properties
    private static let keychain: KeychainType = KeychainManager()

    // MARK: - Internal Static Properties
    static var authToken: String? {
        get {
            return keychain.authToken
        }
        set {
            keychain.authToken = newValue
        }
    }

    static var authEndpointAccessToken: String? {
        return Constants.authEndpointAccessSecretKey
    }

    static var username: String? {
        get {
            return keychain.username
        }
        set {
            keychain.username = newValue
        }
    }

    static var password: String? {
        get {
            return keychain.password
        }
        set {
            keychain.password = newValue
        }
    }

    // MARK: - Initializers
    private init() {}
    
    // MARK: - Static Methods
    static func reset() {
        keychain.authToken = nil
        keychain.username = nil
        keychain.password = nil
    }
    
}
