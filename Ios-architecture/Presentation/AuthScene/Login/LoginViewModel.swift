//
//  LoginViewModel.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/09/09.
//

import Foundation
import Combine

struct LoginViewModelActions {
    let showSignUpVC: () -> Void
    let onLogin: () -> Void
}

final class LoginViewModel: BaseViewModel {

    private let authStorage: AuthStorage = AuthStorage.shared
    private let authUseCase: AuthUseCase
    private let userUseCase: UserUseCase
    private let actions: LoginViewModelActions
    @Published private(set) var loading: Loading
    private var subscriptions: Set<AnyCancellable>

    init(authUseCase: AuthUseCase, userUseCase: UserUseCase, actions: LoginViewModelActions) {
        self.authUseCase = authUseCase
        self.userUseCase = userUseCase
        self.actions = actions
        self.loading = .idle
        self.subscriptions = Set<AnyCancellable>()
    }

    func login(email: String, password: String) {
        guard isLoading() else { return }

        authUseCase.login(email: email, password: password).sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                self.setLoading(.completed)
            case .failure(_):
                self.setLoading(.error)
            }
        }, receiveValue: { token in
            self.authStorage.setToken(token)
            self.authStorage.setUser(token.user)
            self.actions.onLogin()
        }).store(in: &subscriptions)
    }

    func setLoading(_ loading: Loading) {
        self.loading = loading
    }

    func isLoading() -> Bool {
        return loading != .loading
    }

    func showSignUpVC() {
        actions.showSignUpVC()
    }
}
