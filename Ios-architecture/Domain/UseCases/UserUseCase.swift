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

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    func getUser(_ uuid: String) -> AnyPublisher<User, Error> {
        return userRepository.getUser(uuid)
    }

    func getUsers(_ page: Int) -> AnyPublisher<Pagination<[User]>, Error> {
        return userRepository.getUsers(page)
    }
}
