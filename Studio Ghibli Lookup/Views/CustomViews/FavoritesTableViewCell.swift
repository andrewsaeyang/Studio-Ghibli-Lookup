//
//  FavoritesTableViewCell.swift
//  Studio Ghibli Lookup
//
//  Created by Andrew Saeyang on 9/29/21.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    var film: String?{
        didSet{
            updateView()
        }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var filmTitle: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    // MARK: - Actions
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        
    }
    
    // MARK: - Helper Methods
    func updateView(){
        guard let film = film else { return }
        filmTitle.text = film
    }

}
