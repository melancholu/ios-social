//
//  UserUseCase.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/08/26.
//

import Foundation
import Combine

protocol UserUseCaseProtocol {
    func getMe() -> AnyPublisher<User, Error>
    func getUser(_ uuid: String) -> AnyPublisher<User, Error>
    func getUsers(_ page: Int) -> AnyPublisher<Pagination<[User]>, Error>
    func signUp(name: String, email: String, password: String) -> AnyPublisher<User, Error>
}

final class UserUseCase: UserUseCaseProtocol {

    private let userRepository: UserRepository

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

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
