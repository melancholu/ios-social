//
//  CommentRepository.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2024/09/15.
//

import Foundation
import Moya
import Combine

final class CommentRepository: BaseRepository<CommentAPI>, CommentRepositoryProtocol {
    func createComment(_ comment: Comment) -> AnyPublisher<Comment, Error> {
        return provider.requestPublisher(.createComment(comment: comment)).tryMap { response in
            let decodedData = try response.map(Comment.self)

            return decodedData
        }
        .mapError { error in
            return error
        }
        .eraseToAnyPublisher()
    }
}
