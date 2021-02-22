// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let posts = try? newJSONDecoder().decode(Posts.self, from: jsonData)

import Foundation

// MARK: - Posts
struct Posts: Codable {
    let latestPosts: [LatestPost]

    enum CodingKeys: String, CodingKey {
        case latestPosts = "latest_posts"
    }
}

// MARK: - LatestPost
struct LatestPost: Codable {
    let id: Int
    let name : String
}
