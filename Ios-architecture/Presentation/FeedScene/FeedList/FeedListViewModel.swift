//
//  FeedListViewModel.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/08/09.
//

import Foundation
import Combine

struct FeedListViewModelActions {
    let showCreateFeedVC: () -> Void
}

final class FeedListViewModel: BaseViewModel {

    private let feedUseCase: FeedUseCase
    private let actions: FeedListViewModelActions

    @Published private(set) var feeds: [Feed]
    private var nextPage: Int
    private var loading: Loading
    private var subscriptions: Set<AnyCancellable>

    init(feedUseCase: FeedUseCase, actions: FeedListViewModelActions) {
        self.feedUseCase = feedUseCase
        self.actions = actions
        self.feeds = []
        self.nextPage = -1
        self.loading = .idle
        self.subscriptions = Set<AnyCancellable>()
    }

    func getFeeds() {
        guard isLoading() else { return }

        setLoading(.loading)
        feedUseCase.getFeeds(1).sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                self.setLoading(.completed)
            case .failure(let error):
                Log.error(error)
                self.setLoading(.error)
            }
        }, receiveValue: { response in
            let data = response.data
            let meta = response.meta

            self.feeds.append(contentsOf: data)
            self.nextPage = data.count == 0 ? -1 : meta.nextPage
        }).store(in: &subscriptions)
    }

    func loadMore() {
        guard isLoading() else { return }

        if nextPage != -1 {
            setLoading(.loading)
            feedUseCase.getFeeds(nextPage).sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.setLoading(.completed)
                case .failure(let error):
                    Log.error(error)
                    self.setLoading(.error)
                }
            }, receiveValue: { response in
                let data = response.data
                let meta = response.meta

                self.feeds.append(contentsOf: data)
                self.nextPage = data.count == 0 ? -1 : meta.nextPage
            }).store(in: &subscriptions)
        }
    }

    func setLoading(_ loading: Loading) {
        self.loading = loading
    }

    func isLoading() -> Bool {
        return loading != .loading
    }

    func showCreateFeedVC() {
        actions.showCreateFeedVC()
    }
}
