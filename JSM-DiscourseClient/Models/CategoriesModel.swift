//
//  CategoriesModel.swift
//  JSM-DiscourseClient
//
//  Created by Jorge Sanchez on 19/01/2021.

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let categories = try? newJSONDecoder().decode(Categories.self, from: jsonData)
/*
import Foundation



// MARK: - CategoryList
struct CategoryList: Codable {
    let categories: [Category]?
}

// MARK: - Category
struct Category: Codable {
    let id: Int?
    let name: String?
    let lista: CategoryList?
}
*/
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let category = try? newJSONDecoder().decode(Category.self, from: jsonData)

import Foundation

// MARK: - Category
struct Category: Codable {
    var categoryList: CategoryList?

    enum CodingKeys: String, CodingKey {
        case categoryList
    }
}

// MARK: - CategoryList
struct CategoryList: Codable {
    var categories: [CategoryElement]?

    enum CodingKeys: String, CodingKey {
        case categories
    }
}

// MARK: - CategoryElement
struct CategoryElement: Codable {
    var id: Int?
    var name, color, textColor, slug: String?
    

    enum CodingKeys: String, CodingKey {
        case id, name, color
        case textColor
        case slug
    }
}

// MARK: - Encode/decode helpers

