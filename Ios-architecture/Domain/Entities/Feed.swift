//
//  Feed.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 2023/08/19.
//

struct Feed: Identifiable, Codable {
    enum CodingKeys: String, CodingKey {
        case uuid
        case content
        case created
    }

    typealias Identifier = String

    var id: Identifier { uuid }
    let uuid: String
    let content: String
    let created: String
}
