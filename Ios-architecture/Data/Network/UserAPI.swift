//
//  UserAPI.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/08/26.
//

import Moya

enum UserAPI {
    case getUser(uuid: String)
    case getUsers(page: Int)
}

extension UserAPI: TargetType {
    var baseURL: URL {
        URL(string: Env.baseURL)!
    }

    var path: String {
        switch self {
        case .getUser: return "/user"
        case .getUsers: return "/user"
        }
    }

    var method: Method {
        switch self {
        case .getUser: return .get
        case .getUsers: return .get
        }
    }

    var task: Task {
        switch self {
        case let .getUser(uuid):
            return .requestParameters(parameters: ["uuid": uuid], encoding: URLEncoding.queryString)
        case let .getUsers(page):
            return .requestParameters(parameters: ["page": page], encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        return [ "Content-type": "application/json"]
    }
}
