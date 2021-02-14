//
//  Target.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 2/14/21.
//  Copyright © 2021 Daulet. All rights reserved.
//

import Foundation

public enum Target: CaseIterable {

    public static var current = getTarget()
    
    case main
    case unitTest
    case uiTest
    
    private static func getTarget() -> Self {
        let name = Bundle.main.infoDictionary?["CFBundleName"] as! String
        switch name {
        case "HabitTracker":
            return .main
        case "HabitTrackerTests":
            return .unitTest
        case "HabitTrackerUITests":
            return .uiTest
        default:
            assertionFailure("target name should always match")
            return .main
        }
    }
    
}
