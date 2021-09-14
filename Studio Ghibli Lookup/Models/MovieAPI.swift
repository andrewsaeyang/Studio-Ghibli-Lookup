//
//  MovieAPI.swift
//  Studio Ghibli Lookup
//
//  Created by Andrew Saeyang on 9/3/21.
//

import Foundation

struct MovieTopLevelObject:Decodable {
    let page: Int
    let results: [Movie]
}

struct Movie: Decodable{
    
    let movieTitle: String
    let posterImage: URL
    let overview: String
    let rating: Double
    let id: Int
    
    enum CodingKeys: String, CodingKey{
        case movieTitle = "original_title"
        case posterImage = "poster_path"
        case overview = "overview"
        case rating = "vote_average"
        case id = "id"
        
    }
}
