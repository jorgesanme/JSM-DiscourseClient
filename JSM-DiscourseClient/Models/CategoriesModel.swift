//
//  CategoriesModel.swift
//  JSM-DiscourseClient
//
//  Created by Jorge Sanchez on 19/01/2021.

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let categories = try? newJSONDecoder().decode(Categories.self, from: jsonData)


import Foundation

// MARK: - Category
struct Category: Codable {
    var categoryList: CategoryList

    enum CodingKeys: String, CodingKey {
        case categoryList = "category_list"
    }
}

// MARK: - CategoryList
struct CategoryList: Codable {
    var categories: [CategoryElement]
    
}

// MARK: - CategoryElement
struct CategoryElement: Codable {
    var id: Int
    var name: String

    
}

// MARK: - Encode/decode helpers

