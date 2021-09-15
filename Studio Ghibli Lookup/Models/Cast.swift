//
//  Cast.swift
//  Studio Ghibli Lookup
//
//  Created by Andrew Saeyang on 9/14/21.
//

import Foundation

struct CastTopLevelObject: Decodable {
    
    let cast: [Cast]
}



struct Cast: Decodable{
    let id: String
    let name: String
    let knownForDepartment: String
    let character: String
    let profilePath: URL?
    
    enum CodingKeys: String, CodingKey{
        case id, name, character
        case knownForDepartment = "known_for_department"
        case profilePath = "profile_path"
    }
    
}
