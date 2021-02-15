//
//  FastlaneUITests.swift
//  FastlaneUITests
//
//  Created by Daulet Almagambetov on 2/15/21.
//  Copyright © 2021 Daulet. All rights reserved.
//

import XCTest

class FastlaneUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        let app = XCUIApplication()
        
        // 1 - Home
        snapshot("01Home")
        
        // 2 - CreateHabit
        app/*@START_MENU_TOKEN@*/.buttons["Add habit button"]/*[[".buttons[\"add\"]",".buttons[\"Add habit button\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        snapshot("02CreateHabit")
        app.navigationBars["Habit details"].buttons["Back"].tap()
        
        // 3 - Habit
        app.scrollViews.otherElements.scrollViews.otherElements.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Running at 7 am")/*[[".cells.containing(.staticText, identifier:\"4\/21\")",".cells.containing(.staticText, identifier:\"Running at 7 am\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.progressIndicators["Progress"].tap()
        
        snapshot("02DHabit")
    }

}
