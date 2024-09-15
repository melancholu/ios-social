//
//  FeedDetailViewModel.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2024/09/14.
//

import Foundation
import Combine

struct FeedDetailViewModelActions {
}

final class FeedDetailViewModel: BaseViewModel {

    private let feedUseCase: FeedUseCaseProtocol
    private let actions: FeedDetailViewModelActions

    private let feed: Feed

    init(feedUseCase: FeedUseCaseProtocol, actions: FeedDetailViewModelActions, feed: Feed) {
        self.feedUseCase = feedUseCase
        self.actions = actions
        self.feed = feed
    }

    func getFeed() -> Feed {
        return feed
    }
}
