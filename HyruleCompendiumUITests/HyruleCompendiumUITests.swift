//
//  HyruleCompendiumUITests.swift
//  HyruleCompendiumUITests
//
//  Created by Gabriel Colmenares on 19/01/23.
//

import XCTest

final class HyruleCompendiumUITests: XCTestCase {

    func test_search_bar() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let hyruleappNavigationBar = app.navigationBars["Hyruleapp"]
        hyruleappNavigationBar.searchFields["Search"].tap()
        
        let aKey = app/*@START_MENU_TOKEN@*/.keys["A"]/*[[".keyboards.keys[\"A\"]",".keys[\"A\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        aKey.tap()
        
        let bKey = app/*@START_MENU_TOKEN@*/.keys["b"]/*[[".keyboards.keys[\"b\"]",".keys[\"b\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        bKey.tap()
        
        let cKey = app/*@START_MENU_TOKEN@*/.keys["c"]/*[[".keyboards.keys[\"c\"]",".keys[\"c\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        cKey.tap()
        
        let dKey = app/*@START_MENU_TOKEN@*/.keys["d"]/*[[".keyboards.keys[\"d\"]",".keys[\"d\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        dKey.tap()
        
        let eKey = app/*@START_MENU_TOKEN@*/.keys["e"]/*[[".keyboards.keys[\"e\"]",".keys[\"e\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        eKey.tap()
                
        
        XCTAssert(app.staticTexts["No available results, please try again"].exists)
    }
    
    func test_tap_on_settings_button() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        XCUIApplication().navigationBars["Hyruleapp"]/*@START_MENU_TOKEN@*/.buttons["Settings"]/*[[".otherElements[\"Settings\"].buttons[\"Settings\"]",".buttons[\"Settings\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

        XCTAssert(app.staticTexts["Settings"].exists)
    }
}
