//
//  CommentRepositoryProtocol.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2024/09/15.
//

import Foundation
import Combine

protocol CommentRepositoryProtocol {
    func createComment(_ comment: Comment) -> AnyPublisher<Comment, Error>
}
