//
//  LoginViewModelTests.swift
//  Ios-architectureTests
//
//  Created by song dong hyeok on 2023/10/21.
//

import XCTest
import Combine

class LoginViewModelTests: XCTestCase {

    func initToken() {
        let authStorage: AuthStorage = AuthStorage.shared

        authStorage.setToken(nil)
    }

    func test_whenLoginSucceed() {
        initToken()

        let authStorage: AuthStorage = AuthStorage.shared
        let authUseCaseMock = AuthUseCaseMock()
        let actions = LoginViewModelActions(showSignUpVC: {}, onLogin: {})

        let viewModel = LoginViewModel(authUseCase: authUseCaseMock, actions: actions)

        viewModel.login(email: "TEST_EMAIL@gmail.com", password: "TEST_PASSWORD")

        XCTAssertEqual(viewModel.loading, Loading.completed)
        XCTAssertEqual(authStorage.accessToken!, "TEST_ACCESS_TOKEN")
        XCTAssertEqual(authStorage.refreshToken!, "TEST_REFRESH_TOKEN")
    }

    func test_whenLoginFailed() {
        initToken()

        let authStorage: AuthStorage = AuthStorage.shared
        let authUseCaseMock = AuthUseCaseErrorMock()
        let actions = LoginViewModelActions(showSignUpVC: {}, onLogin: {})

        let viewModel = LoginViewModel(authUseCase: authUseCaseMock, actions: actions)

        viewModel.login(email: "TEST_EMAIL@gmail.com", password: "TEST_PASSWORD")

        XCTAssertEqual(viewModel.loading, Loading.error)
        XCTAssertNil(authStorage.accessToken)
        XCTAssertNil(authStorage.refreshToken)
    }
}
