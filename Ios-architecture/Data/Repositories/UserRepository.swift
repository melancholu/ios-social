//
//  UserRepository.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/08/26.
//

import Foundation
import Moya
import Combine

final class UserRepository: UserRepositoryProtocol {
    private let provider = MoyaProvider<UserAPI>(plugins: [NetworkPlugin()])

    func getUser(_ uuid: String) -> AnyPublisher<User, Error> {
        return provider.requestPublisher(.getUser(uuid: uuid)).tryMap { response in
            let decodedData = try response.map(User.self)

            return decodedData
        }
        .mapError { error in
            return error
        }
        .eraseToAnyPublisher()
    }

    func getUsers(_ page: Int = 1) -> AnyPublisher<Pagination<[User]>, Error> {
        return provider.requestPublisher(.getUsers(page: page)).tryMap { response in
            let decodedData = try response.map(Pagination<[User]>.self)

            return decodedData
        }
        .mapError { error in
            return error
        }
        .eraseToAnyPublisher()
    }
}
