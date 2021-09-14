//
//  FavoriteError.swift
//  Studio Ghibli Lookup
//
//  Created by Andrew Saeyang on 9/10/21.
//

import Foundation

enum FavoriteError: LocalizedError {
    case cKerror(Error)
    case couldNotUnwrap
    var errorDescription: String?{
        switch self{
        case .cKerror(let error):
            return error.localizedDescription
            
        case .couldNotUnwrap:
            return "could not unwrap Favorite information"
        }
    }
}

