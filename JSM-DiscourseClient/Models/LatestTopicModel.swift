// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let topic = try? newJSONDecoder().decode(Topic.self, from: jsonData)

import Foundation

// MARK: - Topic
struct Topic: Codable {
    
    let topicList: TopicList?

    enum CodingKeys: String, CodingKey {
        case topicList = "topic_list"
    }
}


// MARK: - TopicList
struct TopicList: Codable {
    
    let topics: [TopicElement]?
    
}

// MARK: - TopicElement
struct TopicElement: Codable {
    let id: Int?
    let title: String?
    let createdAt: String?
    let canDelete: Bool?
    var postNumber: Int
    

    enum CodingKeys: String, CodingKey {
        case id, title
        case createdAt = "created_at"
        case canDelete = "can_delete"
        case postNumber = "posts_count"
    }
}

