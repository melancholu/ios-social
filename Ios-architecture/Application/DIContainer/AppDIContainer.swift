//
//  AppDIContainer.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/07/29.
//

import Foundation

final class AppDIContainer {

    lazy var appConfiguration = AppConfiguration()

    lazy var authRepository: AuthRepository = AuthRepository()
    lazy var feedRepository: FeedRepository = FeedRepository()
    lazy var userRepository: UserRepository = UserRepository()

    func makeAuthDIContainer() -> AuthDIContainer {
        let dependencies = AuthDIContainer.Dependencies(authRepository: authRepository, userRepository: userRepository)

        return AuthDIContainer(dependencies: dependencies)
    }

    func makeTabDIContainer() -> TabDIContainer {
        let dependencies = TabDIContainer.Dependencies(
            feedRepository: feedRepository,
            userRepository: userRepository
        )

        return TabDIContainer(dependencies: dependencies)
    }
}
