//
//  HabitTrackerUITests.swift
//  HabitTrackerUITests
//
//  Created by Daulet on 3/6/20.
//  Copyright © 2020 Daulet. All rights reserved.
//

import XCTest

class HabitTrackerUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        commonSetup()
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


//    func testLaunchPerformance() {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
//                        // This measures how long it takes to launch your application.
//            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
    
    func commonSetup() {
        // 1
        print("SOSAT")
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        // 2
        snapshot("01Home")
        
        // 3
        let addHabitButton = app.buttons["Add habit button"]
        addHabitButton.tap()
        
        snapshot("02CreateHabit")
        
        // 4
        let backButton = app.navigationBars.firstMatch.buttons
        
        
        backButton["Back"].tap()
        
        app.cells.firstMatch.tap()
        snapshot("02DHabit")
        
    }
    
}
