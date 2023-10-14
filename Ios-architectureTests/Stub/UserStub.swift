//
//  UserStub.swift
//  Ios-architectureTests
//
//  Created by song dong hyeok on 2023/10/14.
//

import Foundation

extension User {
    static func stub(
    name: String = "testname",
    email: String = "test@gmail.com",
    password: String = "testpassword") -> Self {
        User(name: name, email: email, password: password)
    }
}
