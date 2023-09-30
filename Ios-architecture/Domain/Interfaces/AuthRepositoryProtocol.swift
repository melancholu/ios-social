//
//  AuthRepositoryProtocol.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/09/29.
//

import Foundation
import Combine

protocol AuthRepositoryProtocol {
    func login(user: User) -> AnyPublisher<Token, Error>
    func logout() -> AnyPublisher<Void, Error>
    func refresh() -> AnyPublisher<Void, Error>
}
