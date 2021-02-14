//
//  Target.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 2/14/21.
//  Copyright © 2021 Daulet. All rights reserved.
//

import Foundation

struct Env {
    
    static var isFastlane: Bool {
        #if DEBUG
            print("DEBUG")
            let dic = ProcessInfo.processInfo.environment
            if let forceProduction = dic["forceProduction"] , forceProduction == "true" {
                return true
            }
            return false
        #elseif ADHOC
            print("ADHOC")
            return false
        #else
            print("PRODUCTION")
            return true
        #endif
    }
    
}

public enum Target: CaseIterable {

    public static var current = getTarget()
    
    case debug
    case release
    case fastlaneUiTest
    
    private static func getTarget() -> Self {
        #if FASTLANE
            return .fastlaneUiTest
        #elseif DEBUG
            return .debug
        #else
            return .release
        #endif
    }
    
}
