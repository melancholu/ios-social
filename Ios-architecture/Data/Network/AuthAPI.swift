//
//  AuthAPI.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/09/29.
//

import Moya

enum AuthAPI {
    case login(user: User)
    case logout
    case refresh
}

extension AuthAPI: BaseAPI {
    var baseURL: URL {
        URL(string: Env.baseURL)!
    }

    var path: String {
        switch self {
        case .login: return "/auth/login"
        case .logout: return "/auth/logout"
        case .refresh: return "/auth/refresh"
        }
    }

    var method: Method {
        switch self {
        case .login: return .post
        case .logout: return .post
        case .refresh: return .post
        }
    }

    var task: Task {
        switch self {
        case let .login(user):
            return .requestJSONEncodable(user)
        case .logout:
            return .requestPlain
        case .refresh:
            return .requestPlain
        }
    }
}
