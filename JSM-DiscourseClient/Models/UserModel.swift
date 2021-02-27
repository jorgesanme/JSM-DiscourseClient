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


// MARK: - UserModel
struct UserModel: Codable {
    var directoryItems: [DirectoryItem]
    

    enum CodingKeys: String, CodingKey {
        case directoryItems = "directory_items"
        
    }
}

// MARK: - DirectoryItem
struct DirectoryItem: Codable {
    var id: Int
    var user: User

    enum CodingKeys: String, CodingKey {
        case id  = "id"
        case user = "user"
    }
}

// MARK: - User
struct User: Codable {
    var id: Int
    var username: String
    var name: String?
    var avatarTemplate: String
    var title: String?

    enum CodingKeys: String, CodingKey {
        case id, username, name
        case avatarTemplate = "avatar_template"
        case title
    }
}
//·······················································

