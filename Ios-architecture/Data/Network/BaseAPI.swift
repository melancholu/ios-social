//
//  BaseAPI.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/09/30.
//

import Moya

protocol BaseAPI: TargetType {}

extension BaseAPI {
    var baseURL: URL {
        URL(string: Env.baseURL)!
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }

    var validationType: ValidationType {
        return .successCodes
    }
}
