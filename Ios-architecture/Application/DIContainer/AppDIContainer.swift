//
//  AppDIContainer.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/07/29.
//

import Foundation

final class AppDIContainer {

    lazy var appConfiguration = AppConfiguration()

    lazy var authRepository: AuthRepositoryProtocol = AuthRepository()
    lazy var commentRepository: CommentRepositoryProtocol = CommentRepository()
    lazy var feedRepository: FeedRepositoryProtocol = FeedRepository()
    lazy var userRepository: UserRepositoryProtocol = UserRepository()

    func makeAuthDIContainer() -> AuthDIContainer {
        let dependencies = AuthDIContainer.Dependencies(authRepository: authRepository, userRepository: userRepository)

        return AuthDIContainer(dependencies: dependencies)
    }

    func makeTabDIContainer() -> TabDIContainer {
        let dependencies = TabDIContainer.Dependencies(
            commentRepository: commentRepository,
            feedRepository: feedRepository,
            userRepository: userRepository
        )

        return TabDIContainer(dependencies: dependencies)
    }
}
