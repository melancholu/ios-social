//
//  TabFlowCoordinator.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/08/02.
//

import Foundation
import UIKit

protocol TabCoordinatorProtocol: Coordinator {
    var tabBarController: UITabBarController { get set }

    func selectPage(_ page: TabBarPage)

    func setSelectedIndex(_ index: Int)

    func currentPage() -> TabBarPage?
}

final class TabFlowCoordinator: NSObject, Coordinator {
    var tabDIContainer: TabDIContainer
    var navigationController: UINavigationController
    var tabBarController: UITabBarController

    required init(tabDIContainer: TabDIContainer, navigationController: UINavigationController) {
        self.tabDIContainer = tabDIContainer
        self.navigationController = navigationController
        self.tabBarController = .init()
    }

    func start() {
        let pages: [TabBarPage] = [.feed, .user, .setting]
            .sorted(by: { $0.pageOrderNumber() < $1.pageOrderNumber() })
        let controllers: [UINavigationController] = pages.map({ getTabController($0) })

        prepareTabBarController(withTabControllers: controllers)
    }

    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        tabBarController.delegate = self
        tabBarController.setViewControllers(tabControllers, animated: true)
        tabBarController.selectedIndex = 0
        tabBarController.tabBar.tintColor = .primary
        tabBarController.tabBar.backgroundColor = .gray100

        navigationController.viewControllers = [tabBarController]
        navigationController.setNavigationBarHidden(true, animated: false)
    }

    private func getTabController(_ page: TabBarPage) -> UINavigationController {
        let navigationController = UINavigationController()
        //        navigationController.setNavigationBarHidden(true, animated: false)
        //        let backBarButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        //        navigationItem.backBarButtonItem = backBarButton
        navigationController.tabBarItem = UITabBarItem.init(title: page.pageTitleValue(),
                                                            image: page.icon(),
                                                            tag: page.pageOrderNumber())

        switch page {
        case .feed:
            let feedDIContainer = tabDIContainer.makeFeedDIContainer()
            let feedFlowCoordinator = feedDIContainer.makeFeedFlowCoordinator(navigationController: navigationController)

            feedFlowCoordinator.start()
        case .user:
            let viewModel = tabDIContainer.makeUserListViewModel()
            let userListVC = UserListViewController.create(with: viewModel)
            navigationController.pushViewController(userListVC, animated: true)
        case .setting:
            let viewModel = tabDIContainer.makeSettingViewModel()
            let settingVC = SettingViewController.create(with: viewModel)
            navigationController.pushViewController(settingVC, animated: true)

        }

        return navigationController
    }

    func currentPage() -> TabBarPage? { TabBarPage.init(index: tabBarController.selectedIndex) }

    func selectPage(_ page: TabBarPage) {
        tabBarController.selectedIndex = page.pageOrderNumber()
    }

    func setSelectedIndex(_ index: Int) {
        guard let page = TabBarPage.init(index: index) else { return }

        tabBarController.selectedIndex = page.pageOrderNumber()
    }
}

// MARK: - UITabBarControllerDelegate
extension TabFlowCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {
    }
}
