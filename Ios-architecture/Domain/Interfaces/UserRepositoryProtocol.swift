//
//  UserRepositoryProtocol.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/08/26.
//

import Foundation
import Combine

protocol UserRepositoryProtocol {
    func getMe() -> AnyPublisher<User, Error>
    func getUser(_ uuid: String) -> AnyPublisher<User, Error>
    func getUsers(_ page: Int) -> AnyPublisher<Pagination<[User]>, Error>
    func signUp(user: User) -> AnyPublisher<User, Error>
}
