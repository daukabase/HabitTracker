//
//  OnboardingPage.swift
//  zhazam
//
//  Created by Nurbek Ismagulov on 5/1/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

enum OnboardingType: CaseIterable {
    case track
    case challenge
    case goal
    case auth
}

struct OnboardingPage {
    var type: OnboardingType
}
