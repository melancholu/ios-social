//
//  UserListViewController.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/08/09.
//

import UIKit
import Combine

class UserListViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!

    private var viewModel: UserListViewModel!
    private var subscriptions = Set<AnyCancellable>()

    static func create(with viewModel: UserListViewModel) -> UserListViewController {
        let view = UserListViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }

    override func setViews() {
        super.setViews()

        tableView.register(UINib(nibName: UserCell.identifier, bundle: nil), forCellReuseIdentifier: UserCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self

        viewModel.getUsers()
    }

    override func setBindings() {
        super.setBindings()

        viewModel.$users
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .store(in: &subscriptions)
    }
}

extension UserListViewController: UITableViewDelegate {}

extension UserListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as? UserCell else {
            return UITableViewCell()
        }

        cell.display(user: viewModel.users[indexPath.row])

        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row > viewModel.users.count - Constant.PAGINATION_OFFSET {
            viewModel.loadMore()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
}
