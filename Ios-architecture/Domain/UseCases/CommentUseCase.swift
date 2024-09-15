//
//  CommentUseCase.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2024/09/15.
//

import Foundation
import Combine

protocol CommentUseCaseProtocol {
    func createComment(_ comment: Comment) -> AnyPublisher<Comment, Error>
}

final class CommentUseCase: CommentUseCaseProtocol {

    private let commentRepository: CommentRepositoryProtocol

    init(commentRepository: CommentRepositoryProtocol) {
        self.commentRepository = commentRepository
    }

    func createComment(_ comment: Comment) -> AnyPublisher<Comment, Error> {
        return commentRepository.createComment(comment)
    }
}
