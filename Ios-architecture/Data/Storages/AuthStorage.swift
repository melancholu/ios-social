//
//  AuthStorage.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/09/09.
//

import Foundation

final class AuthStorage {

    static let shared = AuthStorage()
    private let userDefaults = UserDefaults.standard
    private enum Key: String {
        case accessToken = "ACCESS_TOKEN"
        case refreshToken = "REFRESH_TOKEN"
        case user = "USER"
    }
    private(set) var accessToken: String? {
        get {
            return userDefaults.string(forKey: Key.accessToken.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Key.accessToken.rawValue)
        }
    }
    private(set) var refreshToken: String? {
        get {
            return userDefaults.string(forKey: Key.refreshToken.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Key.refreshToken.rawValue)
        }
    }
    private(set) var user: User? {
        get {
            guard let data = userDefaults.data(forKey: Key.user.rawValue) else {
                return nil
            }

            do {
                return try JSONDecoder().decode(User.self, from: data)
            } catch {
                return nil
            }
        }
        set {
            do {
                let data = try JSONEncoder().encode(newValue)
                userDefaults.set(data, forKey: Key.user.rawValue)
            } catch {}
        }
    }

    func setAccessToken(_ token: String?) {
        self.accessToken = token
    }

    func setRefreshToken(_ token: String?) {
        self.refreshToken = token
    }

    func setUser(_ user: User) {
        self.user = user
    }
}
