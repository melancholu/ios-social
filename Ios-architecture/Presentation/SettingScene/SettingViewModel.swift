//
//  SettingViewModel.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/08/09.
//

import Foundation
import Combine

final class SettingViewModel: BaseViewModel {

    private let userUseCase: UserUseCaseProtocol
    @Published private(set) var user: User?
    private var subscriptions: Set<AnyCancellable>

    init(userUseCase: UserUseCaseProtocol) {
        self.userUseCase = userUseCase
        self.user = AuthStorage.shared.user
        self.subscriptions = Set<AnyCancellable>()
    }

    func getMe() {
        userUseCase.getMe().sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                break
            case .failure(_):
                break
            }
        }, receiveValue: { response in
            AuthStorage.shared.setUser(response)
            self.user = response
        }).store(in: &subscriptions)
    }
}
