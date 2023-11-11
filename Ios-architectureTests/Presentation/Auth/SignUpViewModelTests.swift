//
//  SignUpViewModelTests.swift
//  Ios-architectureTests
//
//  Created by song dong hyeok on 2023/10/21.
//

import XCTest
import Combine

class SignUpViewModelTests: XCTestCase {

    override func setUp() {}

    override func tearDown() {}

    func test_whenSignUpSucceed() {
        let userUseCaseMock = UserUseCaseMock()
        let actions = SignUpViewModelActions(closeSignUpVC: {})

        let viewModel = SignUpViewModel(userUseCase: userUseCaseMock, actions: actions)

        viewModel.signUp(name: "TEST_NAME", email: "TEST_EMAIL@gmail.com", password: "TEST_PASSWORD")

        XCTAssertEqual(viewModel.loading, Loading.completed)
    }

    func test_whenSignUpFailed() {
        let userUseCaseMock = UserUseCaseErrorMock()
        let actions = SignUpViewModelActions(closeSignUpVC: {})

        let viewModel = SignUpViewModel(userUseCase: userUseCaseMock, actions: actions)

        viewModel.signUp(name: "TEST_NAME", email: "TEST_EMAIL@gmail.com", password: "TEST_PASSWORD")

        XCTAssertEqual(viewModel.loading, Loading.error)
    }
}
