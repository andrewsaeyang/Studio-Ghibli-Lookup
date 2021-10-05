//
//  FavoriteController.swift
//  Studio Ghibli Lookup
//
//  Created by Andrew Saeyang on 9/10/21.
//

import Foundation
import CloudKit

class FavoriteController{
    
    static let shared = FavoriteController()
    
    var favorites: [Favorite] = []
    
    let privateDB = CKContainer.default().privateCloudDatabase
    
    //CRUD
    func createFavorite(with id: String, completion: @escaping(Result<String, FavoriteError>) -> Void) {
        let favorite = Favorite(id: id)
        
        let ckRecord = CKRecord(favorite: favorite)
        
        privateDB.save(ckRecord) { record, error in
            if let error = error{
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                return completion(.failure(.couldNotUnwrap))
            }
            
            guard let record = record,
                  let savedFavorite = Favorite(ckRecord: record) else { return completion(.failure(.couldNotUnwrap))}
            
            self.favorites.append(savedFavorite)
            
            completion(.success("successfully created a favorite with id: \(savedFavorite.recordID.recordName)"))
            
        }
    }
    
    
    //query the db
    func favoriteTapped(with fav: Favorite?){
        guard let fav = fav else { return }
        if FavoriteController.shared.favorites.contains(fav){
            print("Removing favorite")
            if let index = FavoriteController.shared.favorites.firstIndex(of: fav){
                FavoriteController.shared.favorites.remove(at: index)
            }
        }else{
            print("Adding new favorite")
            FavoriteController.shared.favorites.append(fav)
            
            
        }
    }
}
