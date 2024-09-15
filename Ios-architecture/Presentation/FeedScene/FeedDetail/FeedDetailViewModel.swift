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

    private let commentUseCase: CommentUseCaseProtocol
    private let actions: FeedDetailViewModelActions
    private(set) var loading: Loading
    private var subscriptions: Set<AnyCancellable>

    private let feed: Feed

    init(commentUseCase: CommentUseCaseProtocol, actions: FeedDetailViewModelActions, feed: Feed) {
        self.commentUseCase = commentUseCase
        self.actions = actions
        self.feed = feed
        self.loading = .idle
        self.subscriptions = Set<AnyCancellable>()
    }

    func getFeed() -> Feed {
        return feed
    }

    func createComment(content: String) {
        guard isLoading() else { return }

        commentUseCase.createComment(Comment(content: content, feed: feed)).sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                self.setLoading(.completed)
            case .failure:
                self.setLoading(.error)
            }
        }, receiveValue: { _ in
        }).store(in: &subscriptions)
    }

    func setLoading(_ loading: Loading) {
        self.loading = loading
    }

    func isLoading() -> Bool {
        return loading != .loading
    }
}
