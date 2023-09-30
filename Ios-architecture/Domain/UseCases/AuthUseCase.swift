//
//  AuthUseCase.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/09/09.
//

import Foundation
import Combine

final class AuthUseCase {

    private let authRepository: AuthRepository

    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }

    func login(email: String, password: String) -> AnyPublisher<Token, Error> {
        let user = User(name: nil, email: email, password: password)

        return authRepository.login(user: user)
    }

    func logout() -> AnyPublisher<Void, Error> {
        return authRepository.logout()
    }

    func refresh() -> AnyPublisher<Void, Error> {
        return authRepository.refresh()
    }
}
