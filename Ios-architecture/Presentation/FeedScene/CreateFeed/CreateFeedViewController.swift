//
//  CreateFeedViewController.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/09/02.
//

import UIKit
import Combine

class CreateFeedViewController: BaseViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var postButton: PrimaryButton!

    private var viewModel: CreateFeedViewModel!

    static func create(with viewModel: CreateFeedViewModel) -> CreateFeedViewController {
        let view = CreateFeedViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }

    override func setViews() {
        super.setViews()

        postButton.button.setTitle("Submit", for: .normal)
        postButton.button.addTarget(self, action: #selector(onClickPost(_:)), for: UIControl.Event.touchUpInside)
    }

    @IBAction func onClickPost(_ sender: Any) {
        guard let text = textView.text else { return }
        guard case text.isEmpty = false else {
            showToast(message: "Enter post")
            return
        }

        viewModel.createFeed(content: text)
    }
}
