//
//  UserModel.swift
//  JSM-DiscourseClient
//
//  Created by Jorge Sanchez on 20/01/2021.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let user = try? newJSONDecoder().decode(User.self, from: jsonData)

import Foundation

// MARK: - User
struct user: Codable {
    var directoryItems: [DirectoryItem]?
    var totalRowsDirectoryItems: Int?
    var loadMoreDirectoryItems: String?

    enum CodingKeys: String, CodingKey {
        case directoryItems
        case totalRowsDirectoryItems
        case loadMoreDirectoryItems
    }
}

// MARK: - DirectoryItem
struct DirectoryItem: Codable {
    var id, timeRead, likesReceived, likesGiven: Int?
    var topicsEntered, topicCount, postCount, postsRead: Int?
    var daysVisited: Int?
    var user: UserClass?

    enum CodingKeys: String, CodingKey {
        case id
        case timeRead
        case likesReceived
        case likesGiven
        case topicsEntered
        case topicCount
        case postCount
        case postsRead
        case daysVisited
        case user
    }
}

// MARK: - UserClass
struct UserClass: Codable {
    var id: Int?
    var username: String?
    var name: String?
    var avatarTemplate: String?
    var title: String?

    enum CodingKeys: String, CodingKey {
        case id, username, name
        case avatarTemplate
        case title
    }
}
