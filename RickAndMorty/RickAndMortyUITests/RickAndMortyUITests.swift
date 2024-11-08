//
//  RickAndMortyUITests.swift
//  RickAndMortyUITests
//
//  Created by Xavier Ramos Sole on 5/11/24.
//

import XCTest

@testable import RickAndMorty

final class RickAndMortyUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app = nil
    }

    @MainActor
    func testNavigation() throws {

        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let scrollView = app.scrollViews["CharacterScrollView"]
 
        XCTAssertTrue(scrollView.waitForExistence(timeout: 2))
        
        let cell = scrollView.descendants(matching: .any)["CharacterCell_1"]
        
        XCTAssertTrue(cell.exists)
        
        cell.tap()
        
        let characterName = app.staticTexts["CharacterName"]
        
        XCTAssertTrue(characterName.exists)
    }

    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
