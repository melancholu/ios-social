//
//  TabBarPage.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/08/02.
//

import Foundation
import UIKit

enum TabBarPage {
    case feed
    case user
    case setting

    init?(index: Int) {
        switch index {
        case 0:
            self = .feed
        case 1:
            self = .user
        case 2:
            self = .setting
        default:
            return nil
        }
    }

    func pageTitleValue() -> String {
        switch self {
        case .feed:
            return "Feed"
        case .user:
            return "User"
        case .setting:
            return "Setting"
        }
    }

    func pageOrderNumber() -> Int {
        switch self {
        case .feed:
            return 0
        case .user:
            return 1
        case .setting:
            return 2
        }
    }

    func icon() -> UIImage {
        switch self {
        case .feed:
            return UIImage.from("icFeed")
        case .user:
            return UIImage.from("icUser")
        case .setting:
            return UIImage.from("icSetting")
        }
    }
}
