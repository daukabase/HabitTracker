//
//  KeychainManager.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 7/22/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import KeychainAccess

protocol KeychainType: class {
    var username: String? { get set }
    var password: String? { get set }

    var authToken: String? { get set }
}

public final class KeychainManager: KeychainType {
    
    private var keychain: Keychain
    
    var authToken: String? {
        get { return keychain[authorizationTokenKey] }
        set { keychain[authorizationTokenKey] = newValue }
    }
    
    var username: String? {
        get { return keychain[usernameKey] }
        set { keychain[usernameKey] = newValue }
    }
    
    var password: String? {
        get { return keychain[passwordKey] }
        set { keychain[passwordKey] = newValue }
    }

    private let authorizationTokenKey = "habit_authorization_token"
    private let usernameKey = "habit_authorization_username"
    private let passwordKey = "habit_authorization_password"

    init() {
        keychain = Keychain()
    }
    
}
