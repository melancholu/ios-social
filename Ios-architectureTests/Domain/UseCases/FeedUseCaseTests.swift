//
//  FeedUseCaseTests.swift
//  Ios-architectureTests
//
//  Created by song dong hyeok on 2023/10/21.
//

import XCTest
import Combine

class FeedUseCaseTests: XCTestCase {
    let feedRepositoryMock: FeedRepository = FeedRepository(.local)
    var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()

    func testFeedUseCase_createFeed() {
        let expectation = XCTestExpectation()
        let feed: Feed = Feed.stub()
        let useCase = FeedUseCase(feedRepository: feedRepositoryMock)

        useCase.createFeed(feed).sink(receiveCompletion: { completion in
        switch completion {
        case .finished:
            break
        case .failure:
            XCTFail("ERROR")
        }
        expectation.fulfill()
        }, receiveValue: { feed in
            XCTAssertEqual(feed.content!, "TEST_CONTENT")
        }).store(in: &subscriptions)

        wait(for: [expectation], timeout: 2.0)
    }

    func testFeedUseCase_getFeeds() {
        let expectation = XCTestExpectation()
        let useCase = FeedUseCase(feedRepository: feedRepositoryMock)

        useCase.getFeeds(1).sink(receiveCompletion: { completion in
        switch completion {
        case .finished:
            break
        case .failure:
            XCTFail("ERROR")
        }
        expectation.fulfill()
        }, receiveValue: { feeds in
            XCTAssertEqual(feeds.data.count, 2)
        }).store(in: &subscriptions)

        wait(for: [expectation], timeout: 2.0)
    }
}
