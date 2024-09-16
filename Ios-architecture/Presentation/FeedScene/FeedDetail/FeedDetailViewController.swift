//
//  FeedDetailViewController.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2024/09/14.
//

import UIKit
import Combine

class FeedDetailViewController: BaseViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var commentProfileImageView: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var postButton: PrimaryButton!
    @IBOutlet weak var tableView: UITableView!

    private var viewModel: FeedDetailViewModel!
    private var subscriptions = Set<AnyCancellable>()

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

        tableView.register(UINib(nibName: CommentCell.identifier, bundle: nil), forCellReuseIdentifier: CommentCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false

        viewModel.getComments()

    }

    override func setBindings() {
        super.setBindings()

        viewModel.$comments
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .store(in: &subscriptions)
    }

    override func setAccessibility() {
        tableView.accessibilityLabel = String(localized: "CommentTableViewAccessbilityLabel")
        tableView.accessibilityIdentifier = "CommentTableView"
        postButton.accessibilityLabel = String(localized: "ReplyButtonAccessbilityLabel")
        postButton.accessibilityIdentifier = "ReplyButton"
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

extension FeedDetailViewController: UITableViewDelegate {}

extension FeedDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.comments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.identifier, for: indexPath) as? CommentCell else {
            return UITableViewCell()
        }

        cell.display(comment: viewModel.comments[indexPath.row])
        cell.accessibilityLabel = viewModel.comments[indexPath.row].content
        cell.accessibilityIdentifier = viewModel.comments[indexPath.row].content

        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row > viewModel.comments.count - Constant.PAGINATION_OFFSET {
            viewModel.loadMore()
        }
    }
}
