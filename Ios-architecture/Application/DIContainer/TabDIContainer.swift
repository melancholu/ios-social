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

    // MARK: - UseCase
    func makeFeedUseCase() -> FeedUseCase {
        return FeedUseCase(feedRepository: dependencies.feedRepository)
    }

    func makeUserUseCase() -> UserUseCase {
        return UserUseCase(userRepository: dependencies.userRepository)
    }

    // MARK: - ViewModel
    func makeFeedListViewModel() -> FeedListViewModel {
        let feedUseCase = makeFeedUseCase()

        return FeedListViewModel(feedUseCase: feedUseCase)
    }

    func makeUserListViewModel() -> UserListViewModel {
        let userUseCase = makeUserUseCase()

        return UserListViewModel(userUseCase: userUseCase)
    }
}
