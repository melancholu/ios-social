//
//  CreateFeedViewModelTests.swift
//  Ios-architectureTests
//
//  Created by song dong hyeok on 2023/10/21.
//

import XCTest
import Combine

class CreateFeedViewModelTests: XCTestCase {

    func test_whenCreateFeedSucceed() {
        let feedUseCaseMock = FeedUseCaseMock()
        let actions = CreateFeedViewModelActions(closeCreateFeedVC: {})

        let viewModel = CreateFeedViewModel(feedUseCase: feedUseCaseMock, actions: actions)

        viewModel.createFeed(content: "TEST_CONTENT")

        XCTAssertEqual(viewModel.loading, Loading.completed)
    }

    func test_whenCreateFeedFailed() {
        let feedUseCaseMock = FeedUseCaseErrorMock()
        let actions = CreateFeedViewModelActions(closeCreateFeedVC: {})

        let viewModel = CreateFeedViewModel(feedUseCase: feedUseCaseMock, actions: actions)

        viewModel.createFeed(content: "TEST_CONTENT")

        XCTAssertEqual(viewModel.loading, Loading.error)
    }
}
