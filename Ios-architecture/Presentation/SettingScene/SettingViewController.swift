//
//  SettingViewController.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/08/09.
//

import UIKit

class SettingViewController: UIViewController, StoryboardInstantiable {

    static func create() -> SettingViewController {
        let view = SettingViewController.instantiateViewController()
        return view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
