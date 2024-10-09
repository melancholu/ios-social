//
//  FeedRepositoryProtocol.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/07/09.
//

import Foundation
import Combine

protocol FeedRepositoryProtocol {
    func createFeed(_ feed: Feed) -> AnyPublisher<Feed, Error>
    func getFeeds(_ page: Int) -> AnyPublisher<Pagination<[Feed]>, Error>
    func like(_ feed: Feed) -> AnyPublisher<Void, Error>
}
