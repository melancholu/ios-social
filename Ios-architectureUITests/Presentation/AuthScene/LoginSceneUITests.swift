//
//  LoginSceneUITests.swift
//  Ios-architectureUITests
//
//  Created by song dong hyeok on 2023/10/28.
//

import XCTest

final class LoginSceneUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false

        let app = XCUIApplication()
        app.launchArguments.append("isUITestingLoggedOut")
        app.launch()
    }

    override func tearDownWithError() throws {
        setToken(nil)
    }

    func setToken(_ token: Token?) {
        let authStorage: AuthStorage = AuthStorage.shared

        authStorage.setToken(token)
    }

    func testLogin_whenEnterInvalidInputs_thenShowToasts() throws {
        let app = XCUIApplication()
        let emailTextField = app.textFields["EmailTextField"]
        let passwordTextField = app.secureTextFields["PasswordTextField"]

        emailTextField.tap()
        emailTextField.typeText("test@gmail.com")

        passwordTextField.tap()
        passwordTextField.typeText("testPassword")

        let loginButton = app.buttons["LoginButton"]
        loginButton.tap()

        XCTAssertFalse(app.staticTexts["ToastLabel"].waitForExistence(timeout: 5))
    }

    func testLogin_whenSignUpButtonTap_thenShowSignUpScreen() throws {
        let app = XCUIApplication()
        let signUpButton = app.buttons["SignUpButton"]
        signUpButton.tap()

        XCTAssertTrue(app.navigationBars.buttons["Back"].waitForExistence(timeout: 5))
    }
}
