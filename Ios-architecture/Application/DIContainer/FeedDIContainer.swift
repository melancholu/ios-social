//
//  FeedDIContainer.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/09/02.
//

import Foundation
import UIKit

final class FeedDIContainer: FeedFlowCoordinatorDependencies {

    struct Dependencies {
        let feedRepository: FeedRepository
    }

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    // MARK: - UseCase
    func makeFeedUseCase() -> FeedUseCase {
        return FeedUseCase(feedRepository: dependencies.feedRepository)
    }

    // MARK: - Flow Coordinators
    func makeFeedFlowCoordinator(navigationController: UINavigationController) -> FeedFlowCoordinator {
        FeedFlowCoordinator(
            navigationController: navigationController,
            dependencies: self
        )
    }

    // MARK: - ViewController
    func makeFeedListViewController(actions: FeedListViewModelActions) -> FeedListViewController {
        let viewModel = makeFeedListViewModel(actions: actions)
        let feedListVC = FeedListViewController.create(with: viewModel)

        return feedListVC
    }

    func makeCreateFeedViewController(actions: CreateFeedViewModelActions) -> CreateFeedViewController {
        let viewModel = makeCreateFeedViewModel(actions: actions)
        let createFeedVC = CreateFeedViewController.create(with: viewModel)

        return createFeedVC
    }

    // MARK: - ViewModel
    func makeFeedListViewModel(actions: FeedListViewModelActions) -> FeedListViewModel {
        let feedUseCase = makeFeedUseCase()

        return FeedListViewModel(feedUseCase: feedUseCase, actions: actions)
    }

    func makeCreateFeedViewModel(actions: CreateFeedViewModelActions) -> CreateFeedViewModel {
        let feedUseCase = makeFeedUseCase()

        return CreateFeedViewModel(feedUseCase: feedUseCase, actions: actions)
    }

}
