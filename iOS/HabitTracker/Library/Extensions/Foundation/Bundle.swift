//
//  Bundle.swift
//  HabitTracker
//
//  Created by Daulet Almagambetov on 12/17/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import Foundation

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}
