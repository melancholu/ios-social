//
//  AuthFlowCoordinator.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/09/09.
//

import Foundation
import UIKit

protocol AuthFlowCoordinatorDependencies {
    func makeLoginViewController(actions: LoginViewModelActions) -> LoginViewController
    func makeSignUpViewController(actions: SignUpViewModelActions) -> SignUpViewController
}

final class AuthFlowCoordinator {

    private weak var navigationController: UINavigationController?
    private let dependencies: AuthFlowCoordinatorDependencies
    weak var delegate: AppFlowDelegate?

    init(navigationController: UINavigationController,
         dependencies: AuthFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }

    func start() {
        let actions = LoginViewModelActions(showSignUpVC: showSignUpVC, onLogin: onLogin)
        let vc = dependencies.makeLoginViewController(actions: actions)

        navigationController?.pushViewController(vc, animated: false)
    }

    func showSignUpVC() {
        let actions = SignUpViewModelActions(closeSignUpVC: closeSignUpVC)
        let vc = dependencies.makeSignUpViewController(actions: actions)

        navigationController?.pushViewController(vc, animated: true)
    }

    func closeSignUpVC() {
        navigationController?.popViewController(animated: true)
    }

    func onLogin() {
        delegate?.onLogin()
    }
}
