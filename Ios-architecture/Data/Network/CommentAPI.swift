//
//  CommentAPI.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2024/09/15.
//

import Foundation
import Moya

enum CommentAPI {
    case createComment(comment: Comment)
}

extension CommentAPI: BaseAPI {
    var path: String {
        switch self {
        case .createComment: return "/comment/"
        }
    }

    var method: Moya.Method {
        switch self {
        case .createComment: return .post
        }
    }

    var task: Task {
        switch self {
        case let .createComment(comment):
            return .requestJSONEncodable(comment)
        }
    }

    var sampleData: Data {
        switch self {
        case .createComment:
            return Data(
                """
                {
                    "uuid": "1",
                    "feed": {
                        "uuid": "TEST_UUID",
                    },
                    "content": "TEST_CONTENT",
                    "created": "2023-10-14T12:40:38.198Z"
                }
                """.utf8
            )
        }
    }
}
