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
    }

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    func makeFeedUseCase() -> FeedUseCase {
        return FeedUseCase(feedRepository: dependencies.feedRepository)
    }

    func makeFeedListViewModel() -> FeedListViewModel {
        let feedUseCase = makeFeedUseCase()

        return FeedListViewModel(feedUseCase: feedUseCase)
    }
}
