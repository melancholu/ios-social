//
//  BaseViewController.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/08/12.
//

import UIKit

class BaseViewController: UIViewController, StoryboardInstantiable {

    override func viewDidLoad() {
        super.viewDidLoad()

        setViews()
        setBindings()
    }

    func setViews() {}

    func setBindings() {}
}
