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

    @Published private(set) var comments: [Comment]
    private(set) var nextPage: Int
    private(set) var loading: Loading
    private var subscriptions: Set<AnyCancellable>

    private let feed: Feed

    init(commentUseCase: CommentUseCaseProtocol, actions: FeedDetailViewModelActions, feed: Feed) {
        self.commentUseCase = commentUseCase
        self.actions = actions
        self.feed = feed
        self.comments = []
        self.nextPage = -1
        self.loading = .idle
        self.subscriptions = Set<AnyCancellable>()
    }

    func getFeed() -> Feed {
        return feed
    }

    func getComments() {
        guard let uuid = feed.uuid else { return }
        guard isLoading() else { return }

        setLoading(.loading)
        commentUseCase.getComments(uuid, 1).sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                self.setLoading(.completed)
            case .failure:
                self.setLoading(.error)
            }
        }, receiveValue: { response in
            let data = response.data
            let meta = response.meta

            self.comments.append(contentsOf: data)
            self.nextPage = data.count == 0 ? -1 : meta.nextPage
        }).store(in: &subscriptions)
    }

    func loadMore() {
        guard let uuid = feed.uuid else { return }
        guard isLoading() else { return }

        if nextPage != -1 {
            setLoading(.loading)
            commentUseCase.getComments(uuid, nextPage).sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.setLoading(.completed)
                case .failure:
                    self.setLoading(.error)
                }
            }, receiveValue: { response in
                let data = response.data
                let meta = response.meta

                self.comments.append(contentsOf: data)
                self.nextPage = data.count == 0 ? -1 : meta.nextPage
            }).store(in: &subscriptions)
        }
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
        }, receiveValue: { response in
            self.comments.insert(response, at: 0)
        }).store(in: &subscriptions)
    }

    func setLoading(_ loading: Loading) {
        self.loading = loading
    }

    func isLoading() -> Bool {
        return loading != .loading
    }
}
