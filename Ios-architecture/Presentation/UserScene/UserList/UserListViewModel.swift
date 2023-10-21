//
//  UserListViewModel.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/08/09.
//

import Foundation
import Combine

final class UserListViewModel: BaseViewModel {

    private let userUseCase: UserUseCaseProtocol
    @Published private(set) var users: [User]
    private var nextPage: Int
    private var loading: Loading
    private var subscriptions: Set<AnyCancellable>

    init(userUseCase: UserUseCaseProtocol) {
        self.userUseCase = userUseCase
        self.users = []
        self.nextPage = -1
        self.loading = .idle
        self.subscriptions = Set<AnyCancellable>()
    }

    func getUsers() {
        guard isLoading() else { return }

        setLoading(.loading)
        userUseCase.getUsers(1).sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                self.setLoading(.completed)
            case .failure(let error):
                Log.error(error)
                self.setLoading(.error)
            }
        }, receiveValue: { response in
            let data = response.data
            let meta = response.meta

            self.users.append(contentsOf: data)
            self.nextPage = data.count == 0 ? -1 : meta.nextPage
        }).store(in: &subscriptions)
    }

    func loadMore() {
        guard isLoading() else { return }

        if nextPage != -1 {
            setLoading(.loading)
            userUseCase.getUsers(nextPage).sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.setLoading(.completed)
                case .failure(let error):
                    Log.error(error)
                    self.setLoading(.error)
                }
            }, receiveValue: { response in
                let data = response.data
                let meta = response.meta

                self.users.append(contentsOf: data)
                self.nextPage = data.count == 0 ? -1 : meta.nextPage
            }).store(in: &subscriptions)
        }
    }

    func setLoading(_ loading: Loading) {
        self.loading = loading
    }

    func isLoading() -> Bool {
        return loading != .loading
    }
}
