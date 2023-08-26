//
//  UserListViewController.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/08/09.
//

import UIKit

class UserListViewController: UIViewController, StoryboardInstantiable {

    static func create() -> UserListViewController {
        let view = UserListViewController.instantiateViewController()
        return view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
