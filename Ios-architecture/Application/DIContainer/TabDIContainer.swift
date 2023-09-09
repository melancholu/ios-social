//
//  TabDIContainer.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/08/26.
//

import Foundation

final class TabDIContainer {

    struct Dependencies {
        let feedRepository: FeedRepository
        let userRepository: UserRepository
    }

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    // MARK: - DIContainer
    func makeFeedDIContainer() -> FeedDIContainer {
        let dependencies = FeedDIContainer.Dependencies(
            feedRepository: dependencies.feedRepository
        )

        return FeedDIContainer(dependencies: dependencies)
    }

    // MARK: - UseCase
    func makeUserUseCase() -> UserUseCase {
        return UserUseCase(userRepository: dependencies.userRepository)
    }

    // MARK: - ViewModel
    func makeUserListViewModel() -> UserListViewModel {
        let userUseCase = makeUserUseCase()

        return UserListViewModel(userUseCase: userUseCase)
    }
}
