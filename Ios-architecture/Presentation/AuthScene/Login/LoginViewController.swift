//
//  LoginViewController.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/09/09.
//

import UIKit
import Combine

class LoginViewController: BaseViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!

    private var viewModel: LoginViewModel!
    private var subscriptions = Set<AnyCancellable>()

    static func create(with viewModel: LoginViewModel) -> LoginViewController {
        let view = LoginViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }

    override func setBindings() {
        super.setBindings()

        viewModel.$loading
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] loading in
                if loading == .completed {

                } else if loading == .error {
                    self?.showToast(message: "Check email or password")
                }
            })
            .store(in: &subscriptions)
    }

    override func setAccessibility() {
        emailTextField.accessibilityLabel = String(localized: "EmailTextFieldAccessbilityLabel")
        emailTextField.accessibilityIdentifier = "EmailTextField"
        passwordTextField.accessibilityLabel = String(localized: "PasswordTextFieldAccessbilityLabel")
        passwordTextField.accessibilityIdentifier = "PasswordTextField"
        signUpButton.accessibilityLabel = String(localized: "SignUpButtonAccessbilityLabel")
        signUpButton.accessibilityIdentifier = "SignUpButton"
        loginButton.accessibilityLabel = String(localized: "LoginButtonAccessbilityLabel")
        loginButton.accessibilityIdentifier = "LoginButton"
    }

    @IBAction func onClickLogin(_ sender: Any) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard case email.isEmpty = false else {
            showToast(message: "Enter email")
            return
        }
        guard case password.isEmpty = false else {
            showToast(message: "Enter password")
            return
        }

        viewModel.login(email: email, password: password)
    }

    @IBAction func onClickSignUp(_ sender: Any) {
        viewModel.showSignUpVC()
    }
}
