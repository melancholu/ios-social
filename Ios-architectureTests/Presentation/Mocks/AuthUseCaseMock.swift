//
//  AuthUseCaseMock.swift
//  Ios-architectureTests
//
//  Created by song dong hyeok on 2023/10/21.
//

import Foundation
import Combine

class AuthUseCaseMock: AuthUseCaseProtocol {
    let authRepositoryMock: AuthRepository = AuthRepository(.local)
    let user: User = User.stub()

    func login(email: String, password: String) -> AnyPublisher<Token, Error> {
        return authRepositoryMock.login(user: user)
    }

    func logout() -> AnyPublisher<Void, Error> {
        return authRepositoryMock.logout()
    }

    func refresh() -> AnyPublisher<Void, Error> {
        return authRepositoryMock.refresh()
    }
}

class AuthUseCaseErrorMock: AuthUseCaseProtocol {
    func login(email: String, password: String) -> AnyPublisher<Token, Error> {
        return Fail(error: NSError(domain: "LOGIN FAIL", code: -1, userInfo: nil)).eraseToAnyPublisher()
    }

    func logout() -> AnyPublisher<Void, Error> {
        return Fail(error: NSError(domain: "LOGOUT FAIL", code: -1, userInfo: nil)).eraseToAnyPublisher()
    }

    func refresh() -> AnyPublisher<Void, Error> {
        return Fail(error: NSError(domain: "REFRESH FAIL", code: -1, userInfo: nil)).eraseToAnyPublisher()
    }
}
