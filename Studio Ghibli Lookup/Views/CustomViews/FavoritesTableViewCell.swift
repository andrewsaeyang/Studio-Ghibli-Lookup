//
//  FavoritesTableViewCell.swift
//  Studio Ghibli Lookup
//
//  Created by Andrew Saeyang on 9/29/21.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var filmTitle: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    // MARK: - Actions
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
