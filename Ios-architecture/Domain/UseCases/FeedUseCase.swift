//
//  FeedUseCase.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/08/26.
//

import Foundation
import Combine

final class FeedUseCase {

    private let feedRepository: FeedRepository

    init(feedRepository: FeedRepository) {
        self.feedRepository = feedRepository
    }

    func createFeed(_ feed: Feed) -> AnyPublisher<Feed, Error> {
        return feedRepository.createFeed(feed)
    }

    func getFeeds(_ page: Int) -> AnyPublisher<Pagination<[Feed]>, Error> {
        return feedRepository.getFeeds(page)
    }
}
