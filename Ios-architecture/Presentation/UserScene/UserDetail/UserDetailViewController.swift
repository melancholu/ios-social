//
//  ViewController.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/07/09.
//

import UIKit

class UserDetailViewController: UIViewController, StoryboardInstantiable {

    static func create() -> UserDetailViewController {
        let view = UserDetailViewController.instantiateViewController()
        return view
    }

}
