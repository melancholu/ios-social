//
//  FeedUseCaseMock.swift
//  Ios-architectureTests
//
//  Created by song dong hyeok on 2023/10/21.
//

import Foundation
import Combine

class FeedUseCaseMock: FeedUseCaseProtocol {
    let feedRepositoryMock: FeedRepository = FeedRepository(.local)

    func createFeed(_ feed: Feed) -> AnyPublisher<Feed, Error> {
        return feedRepositoryMock.createFeed(feed)
    }

    func getFeeds(_ page: Int) -> AnyPublisher<Pagination<[Feed]>, Error> {
        return feedRepositoryMock.getFeeds(page)
    }

    func like(_ feed: Feed) -> AnyPublisher<Void, any Error> {
        return feedRepositoryMock.like(feed)
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

class FeedUseCaseErrorMock: FeedUseCaseProtocol {
    func createFeed(_ feed: Feed) -> AnyPublisher<Feed, Error> {
        return Fail(error: NSError(domain: "CREATE FEED FAIL", code: -1, userInfo: nil)).eraseToAnyPublisher()
    }

    func getFeeds(_ page: Int) -> AnyPublisher<Pagination<[Feed]>, Error> {
        return Fail(error: NSError(domain: "GET FEEDS FAIL", code: -1, userInfo: nil)).eraseToAnyPublisher()
    }

    func like(_ feed: Feed) -> AnyPublisher<Void, any Error> {
        return Fail(error: NSError(domain: "LIKE FAIL", code: -1, userInfo: nil)).eraseToAnyPublisher()
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
