//
//  UserUseCaseMock.swift
//  Ios-architectureTests
//
//  Created by song dong hyeok on 2023/10/21.
//

import Foundation
import Combine

class UserUseCaseMock: UserUseCaseProtocol {
    let userRepository: UserRepository = UserRepository(.local)

    func getMe() -> AnyPublisher<User, Error> {
        return userRepository.getMe()
    }

    func getUser(_ uuid: String) -> AnyPublisher<User, Error> {
        return userRepository.getUser(uuid)
    }

    func getUsers(_ page: Int) -> AnyPublisher<Pagination<[User]>, Error> {
        return userRepository.getUsers(page)
    }

    func signUp(name: String, email: String, password: String) -> AnyPublisher<User, Error> {
        let user = User(name: name, email: email, password: password)

        return userRepository.signUp(user: user)
    }
}

class UserUseCaseErrorMock: UserUseCaseProtocol {
    func getMe() -> AnyPublisher<User, Error> {
        return Fail(error: NSError(domain: "GET ME FAIL", code: -1, userInfo: nil)).eraseToAnyPublisher()
    }

    func getUser(_ uuid: String) -> AnyPublisher<User, Error> {
        return Fail(error: NSError(domain: "GET USER FAIL", code: -1, userInfo: nil)).eraseToAnyPublisher()
    }

    func getUsers(_ page: Int) -> AnyPublisher<Pagination<[User]>, Error> {
        return Fail(error: NSError(domain: "GET USERS FAIL", code: -1, userInfo: nil)).eraseToAnyPublisher()
    }

    func signUp(name: String, email: String, password: String) -> AnyPublisher<User, Error> {
        return Fail(error: NSError(domain: "SIGN UP FAIL", code: -1, userInfo: nil)).eraseToAnyPublisher()
    }
}
