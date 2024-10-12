//
//  FeedRepository.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/07/09.
//

import Foundation
import Moya
import Combine

final class FeedRepository: BaseRepository<FeedAPI>, FeedRepositoryProtocol {
    func createFeed(_ feed: Feed) -> AnyPublisher<Feed, Error> {
        return provider.requestPublisher(.createFeed(feed: feed)).tryMap { response in
            let decodedData = try response.map(Feed.self)

            return decodedData
        }
        .mapError { error in
            return error
        }
        .eraseToAnyPublisher()
    }

    func getFeeds(_ page: Int = 1) -> AnyPublisher<Pagination<[Feed]>, Error> {
        return provider.requestPublisher(.getFeeds(page: page)).tryMap { response in
            let decodedData = try response.map(Pagination<[Feed]>.self)

            return decodedData
        }
        .mapError { error in
            return error
        }
        .eraseToAnyPublisher()
    }

    func like(_ feed: Feed) -> AnyPublisher<Void, Error> {
        return provider.requestPublisher(.like(feed: feed)).tryMap { _ in
            return
        }
        .mapError { error in
            return error
        }
        .eraseToAnyPublisher()
    }
}
