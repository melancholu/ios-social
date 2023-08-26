//
//  AppDelegate.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/07/09.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var appFlowCoordinator: AppFlowCoordinator?
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        AppAppearance.setupAppearance()
        appFlowCoordinator = AppFlowCoordinator(window: window!)
        appFlowCoordinator?.start()

        return true
    }

}
