//
//  SettingViewController.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/08/09.
//

import UIKit
import Combine

class SettingViewController: BaseViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var changePasswordButton: TextButton!
    @IBOutlet weak var privacyButton: TextButton!

    private var viewModel: SettingViewModel!
    private var subscriptions = Set<AnyCancellable>()

    static func create(with viewModel: SettingViewModel) -> SettingViewController {
        let view = SettingViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.getMe()
    }

    override func setViews() {
        super.setViews()

        changePasswordButton.button.setTitle("Change Password", for: .normal)
        changePasswordButton.button.addTarget(self, action: #selector(onClickChangePassword(_:)), for: UIControl.Event.touchUpInside)
        privacyButton.button.setTitle("Privacy policy", for: .normal)
        privacyButton.button.addTarget(self, action: #selector(onClickPrivacy(_:)), for: UIControl.Event.touchUpInside)
    }

    override func setBindings() {
        super.setBindings()

        viewModel.$user
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] user in
                self?.nameLabel.text = user?.name
                self?.emailLabel.text = user?.email
            })
            .store(in: &subscriptions)
    }

    @IBAction func onClickChangePassword(_ sender: Any) {}

    @IBAction func onClickPrivacy(_ sender: Any) {}
}
