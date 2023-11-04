//
//  AuthRepository.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/09/29.
//

import Foundation
import Combine
import CombineMoya

final class AuthRepository: BaseRepository<AuthAPI>, AuthRepositoryProtocol {
    private let authStorage: AuthStorage = AuthStorage.shared

    func login(user: User) -> AnyPublisher<Token, Error> {
        return provider.requestPublisher(.login(user: user)).tryMap { response in
            let decodedData = try response.map(Token.self)

            return decodedData
        }
        .mapError { error in
            return error
        }
        .eraseToAnyPublisher()
    }

    func logout() -> AnyPublisher<Void, Error> {
        return provider.requestPublisher(.logout).tryMap { _ in
            self.authStorage.setToken(nil)
            self.authStorage.setUser(nil)
        }
        .mapError { error in
            return error
        }
        .eraseToAnyPublisher()
    }

    func refresh() -> AnyPublisher<Void, Error> {
        return provider.requestPublisher(.refresh).tryMap { response in
            let decodedData = try response.map(Token.self)

            self.authStorage.setToken(decodedData)
        }
        .mapError { error in
            return error
        }
        .eraseToAnyPublisher()
    }
}
