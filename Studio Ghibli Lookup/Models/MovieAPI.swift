//
//  MovieAPI.swift
//  Studio Ghibli Lookup
//
//  Created by Andrew Saeyang on 9/3/21.
//

import Foundation

struct MovieTopLevelObject: Decodable {
    let page: Int
    let results: [Movie]
    
}

struct Movie: Decodable{
    
    let originalTitle: String
    let posterPath: URL?
    let overview: String
    let rating: Double
    let id: Int
    
    enum CodingKeys: String, CodingKey{
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case overview = "overview"
        case rating = "vote_average"
        case id = "id"
        
    }
    
}
struct CastTopLevelObject: Decodable {
    
    let cast: [Cast]
}

struct Cast: Decodable{
    let id: Int
    let name: String
    let knownForDepartment: String
    let character: String
    let profilePath: URL?
    
    enum CodingKeys: String, CodingKey{
        case id
        case name, character
        case knownForDepartment = "known_for_department"
        case profilePath = "profile_path"
    }
    
}


