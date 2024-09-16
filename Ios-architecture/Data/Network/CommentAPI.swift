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
    case getComments(feedUuid: String, page: Int)
}

extension CommentAPI: BaseAPI {
    var path: String {
        switch self {
        case .createComment: return "/comment/"
        case .getComments: return "/comment/"
        }
    }

    var method: Moya.Method {
        switch self {
        case .createComment: return .post
        case .getComments: return .get
        }
    }

    var task: Task {
        switch self {
        case let .createComment(comment):
            return .requestJSONEncodable(comment)
        case let .getComments(feedUuid, page):
            return .requestParameters(parameters: ["feed": feedUuid, "page": page], encoding: URLEncoding.queryString)
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
        case .getComments:
            return Data(
                """
                {
                    "data": [{
                        "uuid": "1",
                        "user": {
                            "uuid": "TEST_UUID",
                            "name": "TEST_NAME",
                            "email": "TESTEMAIL@gmail.com",
                            "created": "2023-10-14T12:40:38.198Z"
                        },
                        "feed": {
                            "uuid": "TEST_UUID",
                        },
                        "content": "TEST_CONTENT1",
                        "created": "2023-10-14T12:40:38.198Z"
                    }, {
                        "uuid": "2",
                        "user": {
                            "uuid": "TEST_UUID",
                            "name": "TEST_NAME",
                            "email": "TESTEMAIL@gmail.com",
                            "created": "2023-10-14T12:40:38.198Z"
                        },
                        "feed": {
                            "uuid": "TEST_UUID",
                        },
                        "content": "TEST_CONTENT2",
                        "created": "2023-10-14T12:40:38.198Z"
                    }],
                    "meta": {
                        "cur_page": 1,
                        "next_page": 2,
                        "page_num": 5,
                    }
                }
                """.utf8
            )
        }
    }
}
