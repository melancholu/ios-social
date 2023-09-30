//
//  SignUpViewController.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/09/09.
//

import UIKit
import Combine

class SignUpViewController: BaseViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: PrimaryButton!

    private var viewModel: SignUpViewModel!
    private var subscriptions = Set<AnyCancellable>()

    static func create(with viewModel: SignUpViewModel) -> SignUpViewController {
        let view = SignUpViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setViews() {
        super.setViews()

        signUpButton.button.setTitle("SignUp", for: .normal)
        signUpButton.button.addTarget(self, action: #selector(onClickSignUp(_:)), for: UIControl.Event.touchUpInside)
    }

    override func setBindings() {
        super.setBindings()

        viewModel.$loading
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] loading in
                if loading == .error {
                    self?.showToast(message: "Check inputs")
                }
            })
            .store(in: &subscriptions)
    }

    @IBAction func onClickSignUp(_ sender: Any) {
        guard let name = nameTextField.text else { return }
        guard case name.isEmpty = false else {
            showToast(message: "Enter name")
            return
        }
        guard let email = emailTextField.text else { return }
        guard case email.isEmpty = false else {
            showToast(message: "Enter email")
            return
        }
        guard let password = passwordTextField.text else { return }
        guard case password.isEmpty = false else {
            showToast(message: "Enter password")
            return
        }

        viewModel.signUp(name: name, email: email, password: password)
    }
}
