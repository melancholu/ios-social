//
//  Like.swift
//  Ios-architecture
//
//  Created by song dong hyeok on 10/9/24.
//

struct Like: Codable, Equatable {
    enum CodingKeys: String, CodingKey {
        case uuid
        case feed
        case user
        case created
    }

    let uuid: String?
    let feed: Feed?
    let user: User?
    let created: String?

    init(feed: Feed) {
        self.uuid = nil
        self.feed = feed
        self.user = nil
        self.created = nil
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        uuid = (try? container.decodeIfPresent(String.self, forKey: .uuid))
        feed = (try? container.decodeIfPresent(Feed.self, forKey: .feed))
        user = (try? container.decodeIfPresent(User.self, forKey: .user))
        created = (try? container.decodeIfPresent(String.self, forKey: .created))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(uuid, forKey: .uuid)
        try container.encodeIfPresent(feed, forKey: .feed)
        try container.encodeIfPresent(user, forKey: .user)
        try container.encodeIfPresent(created, forKey: .created)
    }

    static func == (lhs: Like, rhs: Like) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
