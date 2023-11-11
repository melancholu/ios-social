//
//  CreateFeedViewModel.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/09/02.
//

import Foundation
import Combine

struct CreateFeedViewModelActions {
    let closeCreateFeedVC: () -> Void
}

final class CreateFeedViewModel: BaseViewModel {

    private let feedUseCase: FeedUseCaseProtocol
    private let actions: CreateFeedViewModelActions
    private(set) var loading: Loading
    private var subscriptions: Set<AnyCancellable>

    init(feedUseCase: FeedUseCaseProtocol, actions: CreateFeedViewModelActions) {
        self.feedUseCase = feedUseCase
        self.actions = actions
        self.loading = .idle
        self.subscriptions = Set<AnyCancellable>()
    }

    func createFeed(content: String) {
        guard isLoading() else { return }

        feedUseCase.createFeed(Feed(content: content)).sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                self.setLoading(.completed)
            case .failure:
                self.setLoading(.error)
            }
        }, receiveValue: { _ in
            self.closeCreateFeedVC()
        }).store(in: &subscriptions)
    }

    func setLoading(_ loading: Loading) {
        self.loading = loading
    }

    func isLoading() -> Bool {
        return loading != .loading
    }

    func closeCreateFeedVC() {
        actions.closeCreateFeedVC()
    }
}
