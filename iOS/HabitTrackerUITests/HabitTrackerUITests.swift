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
        
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func takeScreenShots() {
        let app = XCUIApplication()
        XCUIDevice.shared.orientation = .portrait
        snapshot(“1-Login”) // Takes screenshot of Login screen
        
        let textFieldUserName = app.textFields[“userName”]
        textFieldUserName.tap()
        sleep(1)
        textFieldUserName.typeText(“abc@gmail.com”)
        
        let textFieldPassword = app.secureTextFields[“passwordText”]
        textFieldPassword.tap()
        sleep(1)
        textFieldPassword.typeText(“Abc@123456”)
        
        sleep(1)
        app.buttons[“Login”].tap()
        sleep(8)
        snapshot(“2-CustomerList”)
        // Takes screenshot of CustomerList     screen.
     }
    
    
    
}
