//
//  AppFlowCoordinator.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/07/29.
//

import UIKit

final class AppFlowCoordinator: Coordinator {
    private let window: UIWindow
    private let rootViewController: UINavigationController
    private let appDIContainer: AppDIContainer

    init(window: UIWindow) {
        self.window = window
        self.rootViewController = UINavigationController()
        self.appDIContainer = AppDIContainer()
    }

    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()

        let tabDIContainer = appDIContainer.makeTabDIContainer()
        let tabBarCoordinator = TabFlowCoordinator(tabDIContainer: tabDIContainer, navigationController: rootViewController)
        tabBarCoordinator.start()
    }
}
