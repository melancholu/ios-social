//
//  AppFlowCoordinator.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/07/29.
//

import UIKit

final class AppFlowCoordinator: Coordinator, AppFlowDelegate {
    private let window: UIWindow
    private let rootViewController: UINavigationController
    private let appDIContainer: AppDIContainer

    init(window: UIWindow) {
        self.window = window
        self.rootViewController = UINavigationController()
        self.appDIContainer = AppDIContainer()

        NetworkInterceptor.shared.delegate = self
    }

    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()

        if ProcessInfo.processInfo.arguments.contains("isUITestingLoggedIn") {
            let authStorage: AuthStorage = AuthStorage.shared
            authStorage.setToken(Token(accessToken: "TEST_ACCESS_TOKEN", refreshToken: "TEST_REFRESH_TOKEN"))

            startTabBar()
        } else if ProcessInfo.processInfo.arguments.contains("isUITestingLoggedOut") {
            let authStorage: AuthStorage = AuthStorage.shared
            authStorage.setToken(nil)

            startAuth()
        } else {
            if isLoggedIn() {
                startTabBar()
            } else {
                startAuth()
            }
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
