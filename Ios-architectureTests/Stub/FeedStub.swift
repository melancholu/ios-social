//
//  FeedStub.swift
//  Ios-architectureTests
//
//  Created by song dong hyeok on 2023/10/21.
//

import Foundation

extension Feed {
    static func stub(
        content: String = "testContent") -> Self {
        Feed(content: content)
    }
}
