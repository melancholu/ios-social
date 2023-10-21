//
//  FeedListViewModelTests.swift
//  Ios-architectureTests
//
//  Created by song dong hyeok on 2023/10/21.
//

import XCTest
import Combine

class FeedListViewModelTests: XCTestCase {

    func test_whenCreateFeedSucceed() {
        let feedUseCaseMock = FeedUseCaseMock()
        let actions = FeedListViewModelActions(showCreateFeedVC: {})

        let viewModel = FeedListViewModel(feedUseCase: feedUseCaseMock, actions: actions)

        viewModel.getFeeds()

        XCTAssertEqual(viewModel.loading, Loading.completed)
        XCTAssertEqual(viewModel.nextPage, 2)
        XCTAssertEqual(viewModel.feeds.count, 2)
    }

    func test_whenCreateFeedFailed() {
        let feedUseCaseMock = FeedUseCaseErrorMock()
        let actions = FeedListViewModelActions(showCreateFeedVC: {})

        let viewModel = FeedListViewModel(feedUseCase: feedUseCaseMock, actions: actions)

        viewModel.getFeeds()

        XCTAssertEqual(viewModel.loading, Loading.error)
        XCTAssertEqual(viewModel.nextPage, -1)
        XCTAssertEqual(viewModel.feeds.count, 0)
    }
}
