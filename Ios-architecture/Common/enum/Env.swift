//
//  Env.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/08/19.
//

import Foundation

enum Env {
    enum Keys: String {
        case baseURL = "BASE_URL"
    }

    static let baseURL: String = {
        guard let baseURL = Bundle.main.infoDictionary![Keys.baseURL.rawValue] as? String else {
            fatalError("BASE URL IS NOT SET IN PLIST")
        }

        return baseURL
    }()
}
