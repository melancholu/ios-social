//
//  AuthDIContainer.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/09/09.
//

import Foundation
import UIKit

final class AuthDIContainer: AuthFlowCoordinatorDependencies {

    struct Dependencies {
        let authRepository: AuthRepository
        let userRepository: UserRepository
    }

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    // MARK: - UseCase
    func makeAuthUseCase() -> AuthUseCase {
        return AuthUseCase(authRepository: dependencies.authRepository)
    }

    func makeUserUseCase() -> UserUseCase {
        return UserUseCase(userRepository: dependencies.userRepository)
    }

    // MARK: - Flow Coordinators
    func makeAuthFlowCoordinator(navigationController: UINavigationController) -> AuthFlowCoordinator {
        AuthFlowCoordinator(
            navigationController: navigationController,
            dependencies: self
        )
    }

    // MARK: - ViewController
    func makeLoginViewController(actions: LoginViewModelActions) -> LoginViewController {
        let viewModel = makeLoginViewModel(actions: actions)
        let loginListVC = LoginViewController.create(with: viewModel)

        return loginListVC

    }

    func makeSignUpViewController(actions: SignUpViewModelActions) -> SignUpViewController {
        let viewModel = makeSignUpViewModel(actions: actions)
        let signUpListVC = SignUpViewController.create(with: viewModel)

        return signUpListVC

    }

    // MARK: - ViewModel
    func makeLoginViewModel(actions: LoginViewModelActions) -> LoginViewModel {
        let authUseCase = makeAuthUseCase()
        let userUseCase = makeUserUseCase()

        return LoginViewModel(authUseCase: authUseCase, userUseCase: userUseCase, actions: actions)
    }

    func makeSignUpViewModel(actions: SignUpViewModelActions) -> SignUpViewModel {
        let userUseCase = makeUserUseCase()

        return SignUpViewModel(userUseCase: userUseCase, actions: actions)
    }
}
