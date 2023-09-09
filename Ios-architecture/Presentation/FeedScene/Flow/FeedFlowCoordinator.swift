//
//  FeedFlowCoordinator.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/09/02.
//

import Foundation
import UIKit

protocol FeedFlowCoordinatorDependencies {
    func makeFeedListViewController(actions: FeedListViewModelActions) -> FeedListViewController
    func makeCreateFeedViewController(actions: CreateFeedViewModelActions) -> CreateFeedViewController
}

final class FeedFlowCoordinator {

    private weak var navigationController: UINavigationController?
    private let dependencies: FeedFlowCoordinatorDependencies

    init(navigationController: UINavigationController,
         dependencies: FeedFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func start() {
        let actions = FeedListViewModelActions(showCreateFeedVC: showCreateFeedVC)
        let vc = dependencies.makeFeedListViewController(actions: actions)

        navigationController?.pushViewController(vc, animated: false)
    }

    func showCreateFeedVC() {
        let actions = CreateFeedViewModelActions(closeCreateFeedVC: closeCreateFeedVC)
        let vc = dependencies.makeCreateFeedViewController(actions: actions)

        navigationController?.pushViewController(vc, animated: true)
    }

    func closeCreateFeedVC() {
        navigationController?.popViewController(animated: true)
    }
}
