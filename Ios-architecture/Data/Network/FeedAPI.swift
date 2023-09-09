//
//  FeedAPI.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/08/19.
//

import Moya

enum FeedAPI {
    case createFeed(feed: Feed)
    case getFeeds(page: Int)
}

extension FeedAPI: TargetType {
    var baseURL: URL {
        URL(string: Env.baseURL)!
    }

    var path: String {
        switch self {
        case .createFeed: return "/feed/"
        case .getFeeds: return "/feed"
        }
    }

    var method: Method {
        switch self {
        case .createFeed: return .post
        case .getFeeds: return .get
        }
    }

    var task: Task {
        switch self {
        case let .createFeed(feed):
            return .requestJSONEncodable(feed)
        case let .getFeeds(page):
            return .requestParameters(parameters: ["page": page], encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        return [ "Content-type": "application/json"]
    }

    var validationType: ValidationType {
        return .successCodes
    }
}
