//
//  UserAPI.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/08/26.
//

import Moya

enum UserAPI {
    case getMe
    case getUser(uuid: String)
    case getUsers(page: Int)
    case signUp(user: User)
}

extension UserAPI: BaseAPI {
    var path: String {
        switch self {
        case .getMe: return "/user/me"
        case .getUser: return "/user"
        case .getUsers: return "/user"
        case .signUp: return "/user"
        }
    }

    var method: Method {
        switch self {
        case .getMe: return .get
        case .getUser: return .get
        case .getUsers: return .get
        case .signUp: return .post
        }
    }

    var task: Task {
        switch self {
        case .getMe:
            return .requestPlain
        case let .getUser(uuid):
            return .requestParameters(parameters: ["uuid": uuid], encoding: URLEncoding.queryString)
        case let .getUsers(page):
            return .requestParameters(parameters: ["page": page], encoding: URLEncoding.queryString)
        case let .signUp(user):
            return .requestJSONEncodable(user)
        }
    }
}
