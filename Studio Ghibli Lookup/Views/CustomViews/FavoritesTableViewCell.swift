//
//  FavoritesTableViewCell.swift
//  Studio Ghibli Lookup
//
//  Created by Andrew Saeyang on 9/29/21.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    var favoriteFilm: Favorite?{
        didSet{
            updateView()
        }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var filmTitle: UILabel!
    
    // MARK: - Helper Methods
    func updateView(){
        guard let favoriteFilm = favoriteFilm else { return }
        filmTitle.text = favoriteFilm.filmTitle
    }

}
