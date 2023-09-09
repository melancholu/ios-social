//
//  FeedListViewController.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/08/09.
//
import UIKit
import Combine

class FeedListViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!

    private var viewModel: FeedListViewModel!
    private var subscriptions = Set<AnyCancellable>()

    static func create(with viewModel: FeedListViewModel) -> FeedListViewController {
        let view = FeedListViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }

    override func setViews() {
        super.setViews()

        tableView.register(UINib(nibName: FeedCell.identifier, bundle: nil), forCellReuseIdentifier: FeedCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false

        viewModel.getFeeds()
    }

    override func setBindings() {
        super.setBindings()

        viewModel.$feeds
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .store(in: &subscriptions)
    }

    @IBAction func onClickCreateFeed(_ sender: Any) {
        viewModel.showCreateFeedVC()
    }
}

extension FeedListViewController: UITableViewDelegate {}

extension FeedListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.feeds.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedCell.identifier, for: indexPath) as? FeedCell else {
            return UITableViewCell()
        }

        cell.display(feed: viewModel.feeds[indexPath.row])

        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row > viewModel.feeds.count - Constant.PAGINATION_OFFSET {
            viewModel.loadMore()
        }
    }
}
