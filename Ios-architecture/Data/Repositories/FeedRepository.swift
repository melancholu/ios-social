//
//  FeedRepository.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/07/09.
//

import Foundation
import Moya
import Combine

final class FeedRepository: FeedRepositoryProtocol {
    private let provider = MoyaProvider<FeedAPI>(plugins: [NetworkPlugin()])

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
}
