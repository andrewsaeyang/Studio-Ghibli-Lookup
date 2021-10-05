//
//  BingNewsAPI.swift
//  Studio Ghibli Lookup
//
//  Created by Andrew Saeyang on 10/4/21.
//

import Foundation
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Top Level Object
struct BingTopLevelObject: Codable {
    let type: String?
    let totalEstimatedMatches: Int
    let value: [Value]
    
    enum codingKeys : String, CodingKey{
        case type = "_type"
        case totalEstimatedMatches
        case value
        
    }
}

// MARK: - Value
struct Value: Codable {
    let _type, name: String
    let url: String
    let image: ValueImage?
    //let valueDescription: String
    let provider: [Provider]
    let datePublished: String
}

// MARK: - ValueImage
struct ValueImage: Codable {
    let _type: String
    let thumbnail: PurpleThumbnail
}

// MARK: - PurpleThumbnail
struct PurpleThumbnail: Codable {
    let _type: String
    let contentUrl: String
    let width, height: Int
}

// MARK: - Provider
struct Provider: Codable {
    let _type, name: String
    let image: ProviderImage?
}

// MARK: - ProviderImage
struct ProviderImage: Codable {
    let thumbnail: FluffyThumbnail
}

// MARK: - FluffyThumbnail
struct FluffyThumbnail: Codable {
    let contentUrl: String
}
