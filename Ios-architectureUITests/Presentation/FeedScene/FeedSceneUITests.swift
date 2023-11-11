//
//  FeedSceneUITests.swift
//  Ios-architectureUITests
//
//  Created by song dong hyeok on 2023/11/11.
//

import XCTest

final class FeedSceneUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false

        let app = XCUIApplication()
        app.launchArguments.append("isUITestingLoggedIn")
        app.launch()
    }

    override func tearDownWithError() throws {
        setToken(nil)
    }

    func setToken(_ token: Token?) {
        let authStorage: AuthStorage = AuthStorage.shared

        authStorage.setToken(token)
    }

    func testFeed_whenFetchFeeds_thenShowContents() {
        let app = XCUIApplication()

        XCTAssertTrue(app.staticTexts["TEST_CONTENT1"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts["TEST_CONTENT2"].waitForExistence(timeout: 5))
    }

    func testFeed_whenFetchFeeds_thenCellExits() {
        let app = XCUIApplication()
        let tableView = app.tables["FeedTableView"]
        let cell = tableView.cells["TEST_CONTENT1"]

        XCTAssertTrue(cell.exists)
    }
}
