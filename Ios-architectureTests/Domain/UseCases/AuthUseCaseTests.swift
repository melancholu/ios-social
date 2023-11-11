//
//  AuthUseCaseTests.swift
//  Ios-architectureTests
//
//  Created by song dong hyeok on 2023/10/14.
//

import XCTest
import Combine

class AuthUseCaseTests: XCTestCase {
    let authRepositoryMock: AuthRepository = AuthRepository(.local)
    var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()

    func testAuthUseCase_login() {
        let expectation = XCTestExpectation()
        let user: User = User.stub()
        let useCase = AuthUseCase(authRepository: authRepositoryMock)

        useCase.login(email: user.email!, password: user.password!).sink(receiveCompletion: { completion in
        switch completion {
        case .finished:
            break
        case .failure:
            XCTFail("ERROR")
        }
        expectation.fulfill()
        }, receiveValue: { token in
            XCTAssertEqual(token.accessToken!, "TEST_ACCESS_TOKEN")
            XCTAssertEqual(token.refreshToken!, "TEST_REFRESH_TOKEN")
        }).store(in: &subscriptions)

        wait(for: [expectation], timeout: 2.0)
    }

    func testAuthUseCase_logout() {
        let expectation = XCTestExpectation()
        let useCase = AuthUseCase(authRepository: authRepositoryMock)

        useCase.logout().sink(receiveCompletion: { completion in
        switch completion {
        case .finished:
            break
        case .failure:
            XCTFail("ERROR")
        }
        expectation.fulfill()
        }, receiveValue: { _ in
        }).store(in: &subscriptions)

        wait(for: [expectation], timeout: 2.0)
    }

    func testAuthUseCase_refresh() {
        let expectation = XCTestExpectation()
        let useCase = AuthUseCase(authRepository: authRepositoryMock)

        useCase.refresh().sink(receiveCompletion: { completion in
        switch completion {
        case .finished:
            break
        case .failure:
            XCTFail("ERROR")
        }
        expectation.fulfill()
        }, receiveValue: { _ in
        }).store(in: &subscriptions)

        wait(for: [expectation], timeout: 2.0)
    }
}
