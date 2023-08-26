//
//  User.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/08/26.
//

struct User: Identifiable, Codable {
    enum CodingKeys: String, CodingKey {
        case uuid
        case name
        case email
        case created
        case imageUrl
    }

    typealias Identifier = String

    var id: Identifier { uuid }
    let uuid: String
    let name: String
    let email: String
    let created: String
    let imageUrl: String?
}
