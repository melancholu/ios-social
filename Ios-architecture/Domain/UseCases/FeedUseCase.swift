//
//  FeedUseCase.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/08/26.
//

import Foundation
import Combine

protocol FeedUseCaseProtocol {
    func createFeed(_ feed: Feed) -> AnyPublisher<Feed, Error>
    func getFeeds(_ page: Int) -> AnyPublisher<Pagination<[Feed]>, Error>
    func like(_ feed: Feed) -> AnyPublisher<Void, Error>
    func toggleLike(_ feed: Feed) -> Feed
}

final class FeedUseCase: FeedUseCaseProtocol {

    private let feedRepository: FeedRepositoryProtocol

    init(feedRepository: FeedRepositoryProtocol) {
        self.feedRepository = feedRepository
    }

    func createFeed(_ feed: Feed) -> AnyPublisher<Feed, Error> {
        return feedRepository.createFeed(feed)
    }

    func getFeeds(_ page: Int) -> AnyPublisher<Pagination<[Feed]>, Error> {
        return feedRepository.getFeeds(page)
    }

    func like(_ feed: Feed) -> AnyPublisher<Void, Error> {
        return feedRepository.like(feed)
    }

    func toggleLike(_ feed: Feed) -> Feed {
        var newFeed = feed

        if newFeed.liked == true {
            newFeed.likes = min((newFeed.likes ?? 0) - 1, 0)
        } else {
            newFeed.likes = (newFeed.likes ?? 0) + 1
        }
        newFeed.liked = !(newFeed.liked ?? false)

        return newFeed
    }
}
