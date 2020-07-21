//
//  Config.swift
//  HabitTracker
//
//  Created by Daulet Dev on 7/19/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation

fileprivate let config = Config()

open class Config {
    
    // MARK: - Class Methods
    public class var baseUrl: URL {
        return config.baseUrl
    }
    
    public class var authUrl: URL {
        return config.authUrl
    }
    
    // MARK: - Fileprivate Methods
    fileprivate var baseUrl: URL {
        return URL(string: "https://www.google.com")!
    }
    
    fileprivate var authUrl: URL {
        return URL(string: "https://www.google.com")!
    }
    
    // MARK: - Init
    fileprivate init() {}
    
}
