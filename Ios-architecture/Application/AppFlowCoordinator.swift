//
//  AppFlowCoordinator.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/07/29.
//

import UIKit

protocol AppFlowDelegate: AnyObject {
    func onLogin()
    func onLogout()
}

final class AppFlowCoordinator: Coordinator, AppFlowDelegate {
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

        if isLoggedIn() {
            startTabBar()
        } else {
            startAuth()
        }
    }

    func startTabBar() {
        let tabDIContainer = appDIContainer.makeTabDIContainer()
        let tabBarCoordinator = TabFlowCoordinator(tabDIContainer: tabDIContainer, navigationController: rootViewController)
        tabBarCoordinator.start()
    }

    func startAuth() {
        let authDIContainer = appDIContainer.makeAuthDIContainer()
        let authCoordinator = authDIContainer.makeAuthFlowCoordinator(navigationController: rootViewController)
        authCoordinator.delegate = self
        authCoordinator.start()
    }

    func isLoggedIn() -> Bool {
        let authStorage = AuthStorage.shared

        return authStorage.accessToken != nil
    }

    func onLogin() {
        startTabBar()
    }

    func onLogout() {
        startAuth()
    }
}
