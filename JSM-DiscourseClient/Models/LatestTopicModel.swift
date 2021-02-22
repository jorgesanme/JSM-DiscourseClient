// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topic = try? newJSONDecoder().decode(Topic.self, from: jsonData)

import Foundation

// MARK: - Topic
struct Topic: Codable {
    let users: [User]?
    let primaryGroups: [JSONAny]?
    let topicList: TopicList?

    enum CodingKeys: String, CodingKey {
        case users
        case primaryGroups = "primary_groups"
        case topicList = "topic_list"
    }
}


// MARK: - TopicList
struct TopicList: Codable {
    let canCreateTopic: Bool?
    let moreTopicsURL: String?
    let draft: JSONNull?
    let draftKey: String?
    let draftSequence: JSONNull?
    let perPage: Int?
    let topics: [TopicElement]?

    enum CodingKeys: String, CodingKey {
        case canCreateTopic = "can_create_topic"
        case moreTopicsURL = "more_topics_url"
        case draft
        case draftKey = "draft_key"
        case draftSequence = "draft_sequence"
        case perPage = "per_page"
        case topics
    }
}

// MARK: - TopicElement
struct TopicElement: Codable {
    let id: Int?
    let title, fancyTitle, slug: String?
    let postsCount, replyCount, highestPostNumber: Int?
    let imageURL: String?
    let createdAt, lastPostedAt: String?
    let bumped: Bool?
    let bumpedAt: String?
    let unseen, pinned: Bool?
    let unpinned: JSONNull?
    let excerpt: String?
    let visible, closed, archived: Bool?
    let bookmarked, liked: JSONNull?
    let views, likeCount: Int?
    let hasSummary: Bool?
    let archetype: Archetype?
    let lastPosterUsername: String?
    let categoryID: Int?
    let pinnedGlobally: Bool?
    let featuredLink: JSONNull?
    let posters: [Poster]?

    enum CodingKeys: String, CodingKey {
        case id, title
        case fancyTitle = "fancy_title"
        case slug
        case postsCount = "posts_count"
        case replyCount = "reply_count"
        case highestPostNumber = "highest_post_number"
        case imageURL = "image_url"
        case createdAt = "created_at"
        case lastPostedAt = "last_posted_at"
        case bumped
        case bumpedAt = "bumped_at"
        case unseen, pinned, unpinned, excerpt, visible, closed, archived, bookmarked, liked, views
        case likeCount = "like_count"
        case hasSummary = "has_summary"
        case archetype
        case lastPosterUsername = "last_poster_username"
        case categoryID = "category_id"
        case pinnedGlobally = "pinned_globally"
        case featuredLink = "featured_link"
        case posters
    }
}

enum Archetype: String, Codable {
    case regular = "regular"
}

// MARK: - Poster
struct Poster: Codable {
    let extras: Extras?
    let posterDescription: Description?
    let userID: Int?
    let primaryGroupID: JSONNull?

    enum CodingKeys: String, CodingKey {
        case extras
        case posterDescription = "description"
        case userID = "user_id"
        case primaryGroupID = "primary_group_id"
    }
}

enum Extras: String, Codable {
    case latest = "latest"
    case latestSingle = "latest single"
}

enum Description: String, Codable {
    case frequentPoster = "Frequent Poster"
    case mostRecentPoster = "Most Recent Poster"
    case originalPoster = "Original Poster"
    case originalPosterMostRecentPoster = "Original Poster, Most Recent Poster"
}

// MARK: - User
struct User: Codable {
    let id: Int?
    let username, name, avatarTemplate: String?

    enum CodingKeys: String, CodingKey {
        case id, username, name
        case avatarTemplate = "avatar_template"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public func hash(into hasher: inout Hasher) {
        // No-op
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
