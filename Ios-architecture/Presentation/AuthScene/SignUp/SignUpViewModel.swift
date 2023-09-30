//
//  SignUpViewModel.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/09/09.
//

import Foundation
import Combine

struct SignUpViewModelActions {
    let closeSignUpVC: () -> Void
}

final class SignUpViewModel: BaseViewModel {

    private let userUseCase: UserUseCase
    private let actions: SignUpViewModelActions
    @Published private(set) var loading: Loading
    private var subscriptions: Set<AnyCancellable>

    init(userUseCase: UserUseCase, actions: SignUpViewModelActions) {
        self.userUseCase = userUseCase
        self.actions = actions
        self.loading = .idle
        self.subscriptions = Set<AnyCancellable>()
    }

    func signUp(name: String, email: String, password: String) {
        guard isLoading() else { return }

        userUseCase.signUp(name: name, email: email, password: password).sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                self.setLoading(.completed)
            case .failure(let error):
                Log.debug(error)
                self.setLoading(.error)
            }
        }, receiveValue: { _ in
            self.closeSignUpVC()
        }).store(in: &subscriptions)
    }

    func setLoading(_ loading: Loading) {
        self.loading = loading
    }

    func isLoading() -> Bool {
        return loading != .loading
    }

    func closeSignUpVC() {
        actions.closeSignUpVC()
    }
}
