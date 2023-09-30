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
        setNavigationItem()
    }

    func setViews() {}

    func setBindings() {}

    func setNavigationItem() {
        let backBarButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backBarButton
        self.navigationItem.backBarButtonItem?.tintColor = UIColor.black
    }

    func showToast(message: String) {
        let font = UIFont.systemFont(ofSize: 16)
        let width = min(self.view.frame.size.width-32, message.width(font: font)+32)
        let toastLabel = UILabel(frame: CGRect(x: (self.view.frame.size.width - width)/2,
                                               y: self.view.frame.size.height-130, width: width, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds  =  true

        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 2.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {_ in
            toastLabel.removeFromSuperview()
        })
    }
}
