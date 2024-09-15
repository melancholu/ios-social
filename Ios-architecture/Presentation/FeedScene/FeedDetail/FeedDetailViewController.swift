//
//  FeedDetailViewController.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2024/09/14.
//

import UIKit

class FeedDetailViewController: BaseViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var commentProfileImageView: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var postButton: PrimaryButton!

    private var viewModel: FeedDetailViewModel!

    static func create(with viewModel: FeedDetailViewModel) -> FeedDetailViewController {
        let view = FeedDetailViewController.instantiateViewController()
        view.viewModel = viewModel

        return view
    }

    override func setViews() {
        super.setViews()

        let feed = viewModel.getFeed()

        profileImageView.image = UIImage(named: "icUser")
        nameLabel.text = feed.user?.name ?? ""
        createdLabel.text = feed.created?.readable()
        contentLabel.text = feed.content
        commentProfileImageView.image = UIImage(named: "icUser")
        postButton.button.setTitle("Reply", for: .normal)
        postButton.button.addTarget(self, action: #selector(onClickReply(_:)), for: UIControl.Event.touchUpInside)

    }

    @IBAction func onClickReply(_ sender: Any) {
        guard let text = commentTextField.text else { return }
        guard case text.isEmpty = false else {
            showToast(message: "Enter reply")
            return
        }

        viewModel.createComment(content: text)
    }
}
