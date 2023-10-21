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
}

class FeedUseCaseErrorMock: FeedUseCaseProtocol {
    func createFeed(_ feed: Feed) -> AnyPublisher<Feed, Error> {
        return Fail(error: NSError(domain: "CREATE FEED FAIL", code: -1, userInfo: nil)).eraseToAnyPublisher()
    }

    func getFeeds(_ page: Int) -> AnyPublisher<Pagination<[Feed]>, Error> {
        return Fail(error: NSError(domain: "GET FEEDS FAIL", code: -1, userInfo: nil)).eraseToAnyPublisher()
    }
}
