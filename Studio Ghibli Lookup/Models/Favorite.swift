//
//  SGFilm.swift
//  Studio Ghibli Lookup
//
//  Created by Andrew Saeyang on 9/10/21.
//

import UIKit
import CloudKit

enum FavoriteStrings{
    static let recordKey = "favorite"
    fileprivate static let idKey = "id"
}
class Favorite{
    
    let id: String
    let recordID: CKRecord.ID
    init(id: String, recordID: CKRecord.ID = (CKRecord.ID(recordName: UUID().uuidString))){
        self.id = id
        self.recordID = recordID
        
    }
    
    /*
     hit favorite button, store movie as CKRecord -> private database
     
     fetch favorites from CloudKit > Fetch API with IDs> reload view at call site
     
     fetch cloud kit first> when fetching form SG all films, check if ID is contained in favorites. Toggle button.
     
     */
}

extension CKRecord{
    
    ///turning a favorite into a record
    convenience init(favorite: Favorite){
        self.init(recordType:FavoriteStrings.recordKey, recordID: favorite.recordID)
        
        self.setValuesForKeys([
            FavoriteStrings.idKey : favorite.id
        ])
    }
}

extension Favorite: Equatable{
    convenience init?(ckRecord: CKRecord){
        guard let id = ckRecord[FavoriteStrings.idKey] as? String else { return nil}
        
        self.init(id: id, recordID: ckRecord.recordID)
        
    }
    
    static func == (lhs: Favorite, rhs: Favorite) -> Bool {
        lhs.recordID == rhs.recordID
    }
}
