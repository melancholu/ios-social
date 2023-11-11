//
//  NetworkInterceptor.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/08/20.
//

import Foundation
import Alamofire
import Combine

final class NetworkInterceptor: RequestInterceptor {
    static let shared = NetworkInterceptor()

    private var requestQueue: [(RetryResult) -> Void] = []
    private var isRefreshing: Bool = false
    private var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()
    weak var delegate: AppFlowDelegate?

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        guard urlRequest.url?.absoluteString.hasPrefix(Env.baseURL) == true, let accessToken = AuthStorage.shared.accessToken else {
            completion(.success(urlRequest))
            return
        }

        if urlRequest.url?.absoluteString.hasSuffix("/refresh") == true, let refreshToken = AuthStorage.shared.refreshToken {
            var _urlRequest = urlRequest
            _urlRequest.setValue("Bearer \(refreshToken)", forHTTPHeaderField: "Authorization")
            completion(.success(_urlRequest))
            return
        }

        var _urlRequest = urlRequest
        _urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        completion(.success(_urlRequest))
    }

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard request.response?.statusCode == 401, request.retryCount < 3 else {
            completion(.doNotRetryWithError(error))
            return
        }

        if request.response?.url?.absoluteString.hasSuffix("/refresh") == true {
            logout()
            completion(.doNotRetry)
            return
        } else {
            guard !isRefreshing else {
                requestQueue.append(completion)
                return
            }

            isRefreshing = true

            AuthRepository().refresh().sink(receiveCompletion: { status in
                switch status {
                case .finished:
                    self.isRefreshing = false
                    self.requestQueue.forEach { $0(.retry) }
                    completion(.retry)
                case .failure:
                    self.isRefreshing = false
                    self.logout()
                    completion(.doNotRetry)
                }
            }, receiveValue: { _ in
            }).store(in: &subscriptions)
        }
    }

    func logout() {
        AuthStorage.shared.setToken(nil)
        AuthStorage.shared.setUser(nil)
        DispatchQueue.main.async {
            self.delegate?.onLogout()
        }
    }
}
