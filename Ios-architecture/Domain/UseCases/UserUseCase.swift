//
//  UserUseCase.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/08/26.
//

import Foundation
import Combine

final class UserUseCase {

    private let userRepository: UserRepository
    private var user: User?

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
        self.user = nil
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

    func setUser(user: User) {
        self.user = user
    }

    func signUp(name: String, email: String, password: String) -> AnyPublisher<User, Error> {
        let user = User(name: name, email: email, password: password)

        return userRepository.signUp(user: user)
    }
}
