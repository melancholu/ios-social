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
    //    var type: CoordinatorType { .tab }

    required init(tabDIContainer: TabDIContainer, navigationController: UINavigationController) {
        self.tabDIContainer = tabDIContainer
        self.navigationController = navigationController
        self.tabBarController = .init()
    }

    func start() {
        // Let's define which pages do we want to add into tab bar
        let pages: [TabBarPage] = [.feed, .user, .setting]
            .sorted(by: { $0.pageOrderNumber() < $1.pageOrderNumber() })

        // Initialization of ViewControllers or these pages
        let controllers: [UINavigationController] = pages.map({ getTabController($0) })

        prepareTabBarController(withTabControllers: controllers)
    }

    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        tabBarController.delegate = self
        tabBarController.setViewControllers(tabControllers, animated: true)
        tabBarController.selectedIndex = 0
//        tabBarController.tabBar.isTranslucent = true
        tabBarController.tabBar.tintColor = .primary
        tabBarController.tabBar.backgroundColor = .gray100

        navigationController.viewControllers = [tabBarController]
    }

    private func getTabController(_ page: TabBarPage) -> UINavigationController {
        let navController = UINavigationController()
        navController.setNavigationBarHidden(true, animated: false)
        navController.tabBarItem = UITabBarItem.init(title: page.pageTitleValue(),
                                                     image: page.icon(),
                                                     tag: page.pageOrderNumber())

        switch page {
        case .feed:
            let viewModel = tabDIContainer.makeFeedListViewModel()
            let feedListVC = FeedListViewController.create(with: viewModel)
            navController.pushViewController(feedListVC, animated: true)
        case .user:
            let viewModel = tabDIContainer.makeUserListViewModel()
            let userListVC = UserListViewController.create(with: viewModel)
            navController.pushViewController(userListVC, animated: true)
        case .setting:
            let settingVC = SettingViewController.create()
            navController.pushViewController(settingVC, animated: true)

        }

        return navController
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
        // Some implementation
    }
}
