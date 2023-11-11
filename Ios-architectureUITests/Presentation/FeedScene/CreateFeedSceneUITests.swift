//
//  CreateFeedSceneUITests.swift
//  Ios-architectureUITests
//
//  Created by song dong hyeok on 2023/11/11.
//

import XCTest

final class CreateFeedSceneUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false

        let app = XCUIApplication()
        app.launchArguments.append("isUITestingLoggedIn")
        app.launch()

        let createButton = app.buttons["CreateButton"]
        createButton.tap()
    }

    override func tearDownWithError() throws {
        setToken(nil)
    }

    func setToken(_ token: Token?) {
        let authStorage: AuthStorage = AuthStorage.shared

        authStorage.setToken(token)
    }

    func testCreateFeed_whenPageLoad_thenTextViewWorking() throws {
        let app = XCUIApplication()
        let textView = app.textViews["FeedTextView"]

        textView.tap()
        textView.typeText("This is feed content")

        XCTAssertFalse(app.staticTexts["This is feed content"].waitForExistence(timeout: 5))
    }

    func testCreateFeed_whenPageLoad_thenPostButtonShows() throws {
        let app = XCUIApplication()
        let button = app.buttons["PostFeedButton"]

        XCTAssertTrue(button.exists)
    }
}
