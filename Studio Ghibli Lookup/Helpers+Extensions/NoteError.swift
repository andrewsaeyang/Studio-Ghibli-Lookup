//
//  FavoriteError.swift
//  Studio Ghibli Lookup
//
//  Created by Andrew Saeyang on 9/10/21.
//

import Foundation

enum NoteError: LocalizedError {
    
    case ckError(Error)
    case couldNotUnwrap
    case unexpectRecordsFound
    case noUserLoggedIn
    
    var errorDescription: String? {
        switch self {
        case .ckError(let error):
            return error.localizedDescription
        case .couldNotUnwrap:
            return "Could not get this Hype, bummer man."
        case .unexpectRecordsFound:
            return "Looks like we tried to delete the records, but had an issue."
        case .noUserLoggedIn:
            return "No user logged in."
        }
    }
    
} //End of enum
