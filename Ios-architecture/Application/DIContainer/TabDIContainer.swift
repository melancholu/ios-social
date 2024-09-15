//
//  TabDIContainer.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/08/26.
//

import Foundation

final class TabDIContainer {

    struct Dependencies {
        let commentRepository: CommentRepositoryProtocol
        let feedRepository: FeedRepositoryProtocol
        let userRepository: UserRepositoryProtocol
    }

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    // MARK: - DIContainer
    func makeFeedDIContainer() -> FeedDIContainer {
        let dependencies = FeedDIContainer.Dependencies(
            commentRepository: dependencies.commentRepository,
            feedRepository: dependencies.feedRepository
        )

        return FeedDIContainer(dependencies: dependencies)
    }

    // MARK: - UseCase
    func makeUserUseCase() -> UserUseCaseProtocol {
        return UserUseCase(userRepository: dependencies.userRepository)
    }

    // MARK: - ViewModel
    func makeUserListViewModel() -> UserListViewModel {
        let userUseCase = makeUserUseCase()

        return UserListViewModel(userUseCase: userUseCase)
    }

    func makeSettingViewModel() -> SettingViewModel {
        let userUseCase = makeUserUseCase()

        return SettingViewModel(userUseCase: userUseCase)
    }
}
