//
//  AppDIContainer.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/07/29.
//

import Foundation

final class AppDIContainer {

    lazy var appConfiguration = AppConfiguration()

    lazy var feedRepository: FeedRepository = FeedRepository()

    func makeTabDIContainer() -> TabDIContainer {
        let dependencies = TabDIContainer.Dependencies(
            feedRepository: feedRepository
        )

        return TabDIContainer(dependencies: dependencies)
    }
}
